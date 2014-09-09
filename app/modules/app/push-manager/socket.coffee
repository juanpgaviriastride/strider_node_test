
passportSocketIo = require "passport.socketio"
express = require("express")

auth = require("app/auth").passport


module.exports =
  init: (server, sessionConf, cookieParser) ->
    console.log " initialize socket io module!!!"
    @io = require('socket.io').listen(server)
    SocketRedisStore = require 'socket.io/lib/stores/redis'
    redis_lib = require("redis")
    redis = require '../../../lib/redis'

    @io.configure () =>
      @io.set 'log level', 2
      @io.set 'store', new SocketRedisStore {
        redis: redis_lib
        redisPub : redis.pub
        redisSub : redis.sub
        redisClient : redis.store
      }

      @io.set 'transports', [
        'websocket',
        'xhr-polling',
        'flashsocket',
        'htmlfile',
        'jsonp-polling'
      ]

      # join passport and socket.io authorizations

      @io.set('authorization', passportSocketIo.authorize({
        cookieParser: express.cookieParser,
        key: 'connect.sid',
        store: sessionConf.store,
        secret: sessionConf.secret,
        passport: auth,
        success: @onAuthorizeSuccess,
        fail: @onAuthorizeFail,
      }))

    redis.sub.on "message", (channel, message) =>
      if channel.toString() == "jobs"
        job = JSON.parse(message)
        #console.log "SERRIVCE MESG: ", channel, message
        if job.service == "Services.ScrapLoads"
          @io.sockets.in("room_#{job.user}").emit "/api/v1/external_loads/#{job._id}:update", message
        else
          @io.sockets.in("room_#{job.user}").emit "/api/v1/jobs/#{job._id}:update", message


    redis.sub.subscribe "jobs"

    @io.sockets.on 'connection', (socket) =>
      # connect user id with sockets rooms
      socket.join "room_" + socket.handshake.user._id

      #informer = require "mypa/notification-manager"
      #informer.sendAllNotifications socket.handshake.user
      socket.on 'message', (data) =>
        @io.sockets.in("room_#{socket.handshake.user._id}").emit 'notification', data

    @io.sockets.on 'disconnect', (socket) ->
      console.log "socket disconnected for user: ", socket.handshake.user



  send: (to, message) ->
    console.log 'send notifications to users'
    console.log ' -- users  : ', to
    console.log ' -- message: ', message
    if typeof to isnt 'array'
      to = [to]
    for client in to
      @io.sockets.in("room_#{client}").emit 'notification', message

  isUserOnline: (user) ->
    console.log @io.sockets.clients()
    clients = @io.sockets.clients "room_#{user._id}"
    console.log "isUserOnline: ", clients.length isnt 0
    return clients.length isnt 0

    # socket authorization
  onAuthorizeSuccess: (data, accept) =>
    accept(null, true)
  ,

  onAuthorizeFail: (data, message, error, accept) =>
    if error
      throw new Error(message)

    accept(null, false)
  ,
