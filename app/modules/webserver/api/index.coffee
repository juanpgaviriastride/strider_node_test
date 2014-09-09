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
  apiController.get('/users', auth.passport.authenticate('bearer', { session: false }), (req, res, next) ->
    new UserResource().list(req, res, next)
  )


  # user detail
  apiController.get('/users/:id', auth.passport.authenticate('bearer', { session: false }), (req, res, next) ->
    new UserResource().detail(req, res, next)
  )

  # create new user
  apiController.post('/users', auth.passport.authenticate('bearer', { session: false }), (req, res, next) ->
    new UserResource().create(req, res, next)
  )

  # update new user
  apiController.put('/users/:id', auth.passport.authenticate('bearer', { session: false }), (req, res, next) ->
    new UserResource().update(req, res, next)
  )

  # delete new user
  apiController.del('/users/:id', auth.passport.authenticate('bearer', { session: false }), (req, res, next) ->
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



)
