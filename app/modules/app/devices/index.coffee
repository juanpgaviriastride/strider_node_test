require 'mongoose-pagination'
Model = require "./model"
HTTPStatus = require "http-status"
config = require('../../../config')
async = require "async"
BaseController = require("null/controller/base")

AuthToken = require("app/auth_token")

_ = require 'underscore'

class DeviceController extends BaseController
  model: Model

  create: (params..., callback) =>
    [data, options] = params

    token_request = new DeviceTokenRequestController()
    token_request.getOne {request_token: data.token_request}, (err, res) =>
      return callback(err, null) if err
      return callback(null, null) unless res

      @_createDevice(data.data, res, callback)

  _createDevice: (data, request_token, callback) =>
    data =
      user: request_token.user
      token: data.token

    BaseController::create.call(@, data, (err, res) =>
      return callback(err, null) if err
      return callback(null, null) unless res

      data =
        user_id: res._id
        user_type: 'device'

      @_createAuthToken(data, (error, result) =>
        return callback(err, null) if error
        return callback(null, null) unless result
        res.access_token = result.token

        callback(null, res)
      )
    )

  _createAuthToken: (data, callback) =>
    authToken = new AuthToken()

    authToken.get_or_create {user_id: data.user_id, user_type: data.user_type}, (error, result) ->
      return callback(error, null) if error
      return callback(null,null) unless result

      return callback(null, result)




class DeviceTokenRequestController extends BaseController
  model: Model.TokenRequest





module.exports = DeviceController
module.exports.TokenRequestController = DeviceTokenRequestController
