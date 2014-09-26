express = require "express"
require('express-namespace')

auth = require("app/auth")

apiController = module.exports =  express()

apiController.namespace("/api/v1", () ->
  ##
  # Users controllers
  ##

  UserResource = require("./controllers/users")

  # user list
  apiController.get('/users', (req, res, next) ->
    new UserResource().list(req, res, next)
  )


  # user detail
  apiController.get('/users/:id', (req, res, next) ->
    new UserResource().detail(req, res, next)
  )

  # create new user
  apiController.post('/users', (req, res, next) ->
    new UserResource().create(req, res, next)
  )

  # update new user
  apiController.put('/users/:id', (req, res, next) ->
    new UserResource().update(req, res, next)
  )

  # delete new user
  apiController.del('/users/:id', (req, res, next) ->
    new UserResource().delete(req, res, next)
  )


  ##
  # Comments controllers
  ##


  CommentResource = require "./controllers/comments"

  # list of delivery companies
  apiController.get('/comments', auth.passport.authenticate('bearer', { session: false }), (req, res, next) ->
    new CommentResource().list(req, res, next)
  )

  # detail of delivery company
  apiController.get('/comments/:id', auth.passport.authenticate('bearer', { session: false }), (req, res, next) ->
    new CommentResource().detail(req, res, next)
  )

  # create delivery companies
  apiController.post('/comments', auth.passport.authenticate('bearer', { session: false }), (req, res, next) ->
    new CommentResource().create(req, res, next)
  )

  # update delivery companies
  apiController.put('/comments/:id', auth.passport.authenticate('bearer', { session: false }), (req, res, next) ->
    new CommentResource().update(req, res, next)
  )

  # update delivery companies
  apiController.del('/comments/:id', auth.passport.authenticate('bearer', { session: false }), (req, res, next) ->
    new CommentResource().delete(req, res, next)
  )

  ##
  # Jobs controllers
  ##


  JobResource = require "./controllers/jobs"

  # list of delivery companies
  apiController.get('/jobs', auth.passport.authenticate('bearer', { session: false }), (req, res, next) ->
    new JobResource().list(req, res, next)
  )

  # detail of delivery company
  apiController.get('/jobs/:id', auth.passport.authenticate('bearer', { session: false }), (req, res, next) ->
    new JobResource().detail(req, res, next)
  )

  # create delivery companies
  apiController.post('/jobs', auth.passport.authenticate('bearer', { session: false }), (req, res, next) ->
    new JobResource().create(req, res, next)
  )

  # update delivery companies
  apiController.put('/jobs/:id', auth.passport.authenticate('bearer', { session: false }), (req, res, next) ->
    new JobResource().update(req, res, next)
  )

  # update delivery companies
  apiController.del('/jobs/:id', auth.passport.authenticate('bearer', { session: false }), (req, res, next) ->
    new JobResource().delete(req, res, next)
  )

  ##
  # Cron Jobs controllers
  ##

  # list of delivery companies
  apiController.get('/cron_jobs', (req, res, next) ->
    new JobResource.CronJobResource().list(req, res, next)
  )

  # detail of delivery company
  apiController.get('/cron_jobs/:id', (req, res, next) ->
    new JobResource.CronJobResource().detail(req, res, next)
  )

  ##
  # Patietns controllers
  ##


  PatientsResource = require "./controllers/patients"

  # list of delivery patietns
  apiController.get('/patients', (req, res, next) ->
    new PatientsResource().list(req, res, next)
  )

  # detail of delivery patietns
  apiController.get('/patients/:id', (req, res, next) ->
    new PatientsResource().detail(req, res, next)
  )

  # create delivery patietns
  apiController.post('/patients', (req, res, next) ->
    new PatientsResource().create(req, res, next)
  )

  # update delivery patietns
  apiController.put('/patients/:id', (req, res, next) ->
    new PatientsResource().update(req, res, next)
  )

  # update delivery patietns
  apiController.del('/patients/:id', (req, res, next) ->
    new PatientsResource().delete(req, res, next)
  )

  ##
  # Surgery controllers
  ##


  SurgeriesResource = require "./controllers/surgeries"

  # list of delivery surgeries
  apiController.get('/surgeries', (req, res, next) ->
    new SurgeriesResource().list(req, res, next)
  )

  # detail of delivery surgeries
  apiController.get('/surgeries/:id', (req, res, next) ->
    new SurgeriesResource().detail(req, res, next)
  )

  # create delivery surgeries
  apiController.post('/surgeries', (req, res, next) ->
    new SurgeriesResource().create(req, res, next)
  )

  # update delivery surgeries
  apiController.put('/surgeries/:id', (req, res, next) ->
    new SurgeriesResource().update(req, res, next)
  )

  # update delivery surgeries
  apiController.del('/surgeries/:id', (req, res, next) ->
    new SurgeriesResource().delete(req, res, next)
  )


  ##
  # Locations controllers
  ##


  LocationsResource = require "./controllers/locations"

  # list of delivery locations
  apiController.get('/locations', (req, res, next) ->
    new LocationsResource().list(req, res, next)
  )

  # detail of delivery locations
  apiController.get('/locations/:id', (req, res, next) ->
    new LocationsResource().detail(req, res, next)
  )

  # create delivery locations
  apiController.post('/locations', (req, res, next) ->
    new LocationsResource().create(req, res, next)
  )

  # update delivery locations
  apiController.put('/locations/:id', (req, res, next) ->
    new LocationsResource().update(req, res, next)
  )

  # update delivery locations
  apiController.del('/locations/:id', (req, res, next) ->
    new LocationsResource().delete(req, res, next)
  )


  ##
  # Messages controllers
  ##


  MessagesResource = require "./controllers/messages"

  # list of delivery messages
  apiController.get('/messages', (req, res, next) ->
    new MessagesResource().list(req, res, next)
  )

  # detail of delivery messages
  apiController.get('/messages/:id', (req, res, next) ->
    new MessagesResource().detail(req, res, next)
  )

  # create delivery messages
  apiController.post('/messages', (req, res, next) ->
    new MessagesResource().create(req, res, next)
  )

  # update delivery messages
  apiController.put('/messages/:id', (req, res, next) ->
    new MessagesResource().update(req, res, next)
  )

  # update delivery messages
  apiController.del('/messages/:id', (req, res, next) ->
    new MessagesResource().delete(req, res, next)
  )

  ##
  # Assets controllers
  ##

  # TODO: put this junk somewhere better
  assets_conn = () ->
    nano = require 'nano'
    conf = require '../../../config'
    # connect to CouchDB via nano
    schema = 'http'
    auth = ''
    host = conf.get('couchdb').host
    port = conf.get('couchdb').port
    nano([schema, '://', auth, host, ':', port, '/'].join('')).use('asset')


  # create binary asset
  apiController.post('/assets', (req, res, next) ->
    fs = require 'fs'
    uuid = require 'node-uuid'
    assets = assets_conn()
    # pipe saved file named 'asset' to couch
    # TODO: interrogate asset to discover mime type, don't trust the client
    unless req.files.asset?
      res.status(500).send("{\"error\":\"Asset required\"}")
      return
    content_type = req.files.asset.headers['content-type']
    doc_id = uuid.v1()
    to_user_id = req.body.to
    reader = fs.createReadStream(req.files.asset.path)
    # TODO: deal with duplicate ids
    reader.pipe(
      assets.attachment.insert(doc_id, 'blob', null, content_type)
    )
    reader.on 'error', (err)->
      res.status(500).send("{\"error\":\"#{err}\", \"id\":\"#{doc_id}\"}")
    reader.on 'end', ->
      # TODO: fire off a message to XMPP to_user_id
      res.status(200).send("{\"status\":\"ok\", \"id\":\"#{doc_id}\"}")
  )

  apiController.get('/assets/:id', (req, res, next) ->
    assets = assets_conn()
    doc_id = req.params.id
    assets.attachment.get(doc_id, 'blob').pipe(res)
  )


  ##
  # Devices controllers
  ##

  DevicesResource = require "./controllers/devices"

  # list of delivery messages
  apiController.get('/devices', (req, res, next) ->
    new DevicesResource().list(req, res, next)
  )

  # detail of delivery messages
  apiController.get('/devices/:id', (req, res, next) ->
    new DevicesResource().detail(req, res, next)
  )

  # create delivery messages
  apiController.post('/devices/token/:request_token', (req, res, next) ->
    new DevicesResource().create(req, res, next)
  )

  # update delivery messages
  apiController.put('/devices/:id', (req, res, next) ->
    new DevicesResource().update(req, res, next)
  )

  # update delivery messages
  apiController.del('/devices/:id', (req, res, next) ->
    new DevicesResource().delete(req, res, next)
  )

  ## Device request token
  # create delivery messages
  apiController.post('/auth/devices/request_token', (req, res, next) ->
    new DevicesResource.TokenRequestResource().create(req, res, next)
  )

  ##
  # Contacts controllers
  ##


  ContactsResource = require "./controllers/contacts"

  # list of delivery messages
  apiController.get('/contacts', (req, res, next) ->
    new ContactsResource().list(req, res, next)
  )

  # detail of delivery messages
  apiController.get('/contacts/:id', (req, res, next) ->
    new ContactsResource().detail(req, res, next)
  )

  # create delivery messages
  apiController.post('/contacts', (req, res, next) ->
    new ContactsResource().create(req, res, next)
  )

  # update delivery messages
  apiController.put('/contacts/:id', (req, res, next) ->
    new ContactsResource().update(req, res, next)
  )

  # update delivery messages
  apiController.del('/contacts/:id', (req, res, next) ->
    new ContactsResource().delete(req, res, next)
  )
)
