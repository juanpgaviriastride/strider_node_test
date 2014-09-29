async = require "async"
_ = require 'underscore'
orm = require "../../../lib/orm"
BaseManager = require("null/models/base_manager")
config = require('../../../config')

AuthToken = require("app/auth_token")
User = require("app/users")


class DeviceController extends BaseManager
  model_identifier: 'device'

  create: (params..., callback) =>
    [data, options] = params

    token_request = new DeviceTokenRequestController()
    token_request.model.findOne().where({request_token: data.token_request}).populate('user').exec (err, token_request) =>
      return callback(err, null) if err
      return callback(null, null) unless token_request
      @_getDeviceBySerial(data.data, (err, device) =>
        return callback(err, null) if err
        return @_createDevice(data.data, token_request, callback) unless device

        auth_token_info =
          user_id: device.id
          user_type: 'device'

        @_createAuthToken(auth_token_info, (error, access_token) =>
          return callback(err, null) if error
          return callback(null, null) unless access_token
          device.access_token = access_token.token
          device.host_url = token_request.host_url
          device.im_uri = "xmpp:#{token_request.user.username}@#{config.get('app').im?.xmpp.host}:#{config.get('app').im?.xmpp.port}"

          callback(null, device)
        )
      )


  _createDevice: (data, request_token, callback) =>
    data =
      user: request_token.user
      token: data.token

    BaseManager::create.call(@, data, (err, res) =>
      return callback(err, null) if err
      return callback(null, null) unless res

      data =
        user_id: res.id
        user_type: 'device'

      @_createAuthToken(data, (error, result) =>
        return callback(err, null) if error
        return callback(null, null) unless result
        res.access_token = result.token
        res.host_url = result.host_url
        User.getOne {id: result.user_id}, (err, user) =>
          res.im_uri = "xmpp:#{user.username}@#{config.get('app').im?.xmpp.host}:#{config.get('app').im?.xmpp.port}"
          callback(null, res)
      )
    )

  _getDeviceBySerial: (data, callback) =>
    @getOne({token: data.token}, (err, res) =>
      return callback(err, res)
    )

  _createAuthToken: (data, callback) =>
    authToken = new AuthToken()

    authToken.get_or_create {user_id: data.user_id, user_type: data.user_type}, (error, result) ->
      return callback(error, null) if error
      return callback(null,null) unless result

      return callback(null, result)



class DeviceTokenRequestController extends BaseManager
  model_identifier: 'device_token_request'


module.exports = DeviceController
module.exports.TokenRequestController = DeviceTokenRequestController
