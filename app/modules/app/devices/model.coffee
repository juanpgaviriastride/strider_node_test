fs = require "fs"
config = require('../../../config')
Waterline = require("waterline")

jwt = require "jwt-simple"


Device = Waterline.Collection.extend(
  identity: 'device'
  connection: 'couchdb'

  attributes: {
    id: { type: 'string', primaryKey: true, unique: true }
    "user": { model: 'user' },
    "token": {type: 'string'},
  }
)

# TODO: check viertual fields
# Device.virtual('access_token').get( () ->
#   return @_access_token
# )
#
# Device.virtual('access_token').set( (access_token) ->
#   @_access_token = access_token
# )

DeviceTokenRequest = Waterline.Collection.extend(
  identity: 'device_token_request'
  connection: 'couchdb'

  attributes: {
    id: { type: 'string', primaryKey: true, unique: true }
    "user": { model: 'user' },
    "status": {type: 'string', defaultsTo: "sent"}
    "host_url": {type: 'string', defaultsTo: config.get('app').baseUrl},
    "request_token": {type: 'string'},
  }

  beforeCreate: (values, next) =>
    context = {
      user: values.user
      timestamp: (new Date()).toISOString()
    }

    values.request_token = jwt.encode(context, config.get("request_token_secret"))
    next()
)

module.exports = Device
module.exports.TokenRequest = DeviceTokenRequest
