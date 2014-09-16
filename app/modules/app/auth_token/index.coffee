# Null token auth jobs
require 'mongoose-pagination'
Model = require "./model"
HTTPStatus = require "http-status"
config = require('../../../config')
async = require "async"
BaseController = require("null/controller/base")
_ = require 'underscore'
orm = require "../../../lib/orm"

class AuthTokenController

  constructor: (options) ->
    @initialize options

  initialize: (options) =>
    #SMELL: make this a lazy evaluation of a config string?
    @model = orm.models.authtoken
    return

  get_or_create: (user_id, callback) =>
    @model.findOne().where(user_id: user_id).exec (err, res) =>
      return callback(err, null) if err
      if res?
        callback(null, res)
      else
        context = user_id: user_id
        scope = ["user"]
        token = @model.create(user_id: user_id, scope: ['api']).exec (error, result) =>
          return callback(error, result)

  verify: (token, callback) =>
    @model.findOne().where(token: token).exec(error, result) ->
      return callback(error, null) if error
        callback(null, result)


module.exports = AuthTokenController
