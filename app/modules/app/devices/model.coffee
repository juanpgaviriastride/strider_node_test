fs = require "fs"
mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId
_ = require 'lodash'
schemaHelpers = require 'null/schema-helpers'
env = process.env.NODE_ENV || 'local'
config = require('../../../config')

jwt = require "jwt-simple"


Device = new Schema({
  "created": {type: Date}
  "user": { type: Schema.Types.ObjectId, ref: 'user' }
  "token": {type: String, required: false}
#})
 },{
     toObject: { virtuals: true, getters: true },
     toJSON: { virtuals: true, getters: true }
 })

Device.virtual('access_token').get( () ->
  return @_access_token
)

Device.virtual('access_token').set( (access_token) ->
  @_access_token = access_token
)

#Device.plugin schemaHelpers


DeviceTokenRequest = new Schema
  "created": {type: Date}
  "user": { type: Schema.Types.ObjectId, ref: 'user', required: true}
  "status": {type: String, default: "sent"}
  "host_url": {type: String, default: config.get('app').baseUrl}
  "request_token": {type: String, required: false}

DeviceTokenRequest.pre 'save', (next) ->
  if @isNew
    @created = new Date()

  context = {
    user: @user
    timestamp: @created
  }

  @request_token = jwt.encode(context, config.get("request_token_secret"))
  next()


DeviceTokenRequest.plugin schemaHelpers

module.exports = mongoose.model 'device', Device
module.exports.TokenRequest = mongoose.model 'device_token_request', DeviceTokenRequest
