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
  "username"        : {type: String, required: true, index: { unique: true }}
  "hashed_password" : String
  "salt"            : String
  "apn_token"       : String
  "active"          : {type: Boolean, default: true}

  "ssn":  {type: String, required: false},
  "name": {
    "prefix": {type: String, required: false},
    "first":  {type: String, required: false},
    "last":  {type: String, required: false}
  },
  "dob":  {type: Date, required: false},
  "profileUrl":  {type: String, required: false},
  "role":  {type: String, required: false},
  "contactInfo": {
    "phone":{
      "office":  {type: String, required: false}
      "cell":  {type: String, required: false}
    },
    "email":{
      "personal":  {type: String, required: false}
      "work":  {type: String, required: false}
    }
  }

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

User.pre "save", (next) ->

  if @isNew
    @dob = new Date()
  next()



module.exports = mongoose.model 'user', User
