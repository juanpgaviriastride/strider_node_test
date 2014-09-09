require 'mongoose-pagination'
User = require "./model"
HTTPStatus = require "http-status"
config = require('../../../config')
async = require "async"
BaseController = require("null/controller/base")
_ = require 'underscore'

class UserController extends BaseController
  model: User


  create: (params..., callback) =>
    [data, options] = params
    async.waterfall [
      (cb) ->
        new_user = new User data
        new_user.save (err, saved_user) ->
          switch err?.name
            when "ValidationError"
              err.status = HTTPStatus.BAD_REQUEST
          switch err?.code
          # duplicate key error
          # duplicate key on update
            when 11000, 11001
              err.status = HTTPStatus.CONFLICT
          cb err, saved_user
    ], (err, user) ->
      callback err, user
  ,



module.exports = UserController
