config = require('../../../config')
_ = require("underscore")
jwt = require('jwt-simple')
uniqueValidator = require('mongoose-unique-validator')
mongoose = require('mongoose')

Schema = mongoose.Schema

## User Schema
authTokenSchema = new Schema({
  token:  { type: String }
  user_type: { type: String }
  user_id:  { type: String, required: false }
  scope: [{type: String}]
})

## Validate Unique
authTokenSchema.plugin(uniqueValidator)

## Pre save hook to set up password has
authTokenSchema.pre 'save', (next) ->
  token = this
  context = {
    scope: token.scope
    user_id: token.user_id
    user_type: token.user_type
    timestamp: (new Date()).toISOString
  }

  token.token = jwt.encode(context, config.get("auth_token_secret"))
  next()


## get or create method
authTokenSchema.statics.get_or_create = (options, callback) ->
  @findOne {"user_id": options.user_id, "user_type": options.user_type}, (error, result) ->
    return callback(error, null) if error
    if result is null
      context =
        user_id: options.user_id
        user_type: options.user_type

      token = new AuthToken({user_id: options.user_id, user_type: options.user_type, scope: ['api']})
      token.save (error,result) ->
        return callback(error, null) if error
        return callback(null,result)
    else
      callback(null, result)

## verify method
authTokenSchema.statics.verify = (token, callback) ->
  @findOne({token: token}, (error, result) ->
    return callback(error, null) if error
    if result == null
      callback(null, null)
    else
      callback(null, result)
  )


## AuthToken model
AuthToken = mongoose.model('AuthToken', authTokenSchema)

## Export User model
module.exports = AuthToken
