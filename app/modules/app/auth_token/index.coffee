# Null token auth jobs
require 'mongoose-pagination'
Model = require "./model"
HTTPStatus = require "http-status"
config = require('../../../config')
async = require "async"
BaseController = require("null/controller/base")
_ = require 'underscore'

class AuthTokenController extends BaseController
  model: Model

  get_or_create: (user_id, callback) =>
    Model.get_or_create(user_id, callback)

  verify: (token, callback) =>
    Model.verify(token, callback)

module.exports = AuthTokenController
