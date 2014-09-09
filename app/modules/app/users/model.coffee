fs = require "fs"
mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId
crypto = require 'crypto'
_ = require 'lodash'
schemaHelpers = require 'null/schema-helpers'
env = process.env.NODE_ENV || 'local'
config = require('../../../config')

User = new Schema
  full_name       : {type: String, required: true}
  email           : {type: String, required: true, index: { unique: true }}
  username        : {type: String, required: true, index: { unique: true }}
  provider        : String
  hashed_password : String
  salt            : String
  apn_token       : String
  active          : {type: Boolean, default: true}
  role            : {type: String, default: 'member', required: true}

User.plugin schemaHelpers

User
  .virtual('password')
  .set (password) ->
    @_password = password
    @salt = @makeSalt()
    @hashed_password = @encryptPassword(password)
  .get () ->
    return @_password


User.virtual('token').get(() ->
  return @_token
)

User.virtual('token').set((token) ->
  console.log "SET TOKEN: ", token
  @_token = token
  return
)

User
  .method 'authenticate', (plainText) ->
    return @encryptPassword(plainText) == @hashed_password

User
  .method 'makeSalt', () ->
    return Math.round((new Date().valueOf() * Math.random())) + ''

User
  .method 'encryptPassword', (password) ->
    return crypto.createHmac('sha1', @salt).update(password).digest('hex')





module.exports = mongoose.model 'user', User
