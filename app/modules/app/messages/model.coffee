fs = require "fs"
mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId
_ = require 'lodash'
schemaHelpers = require 'null/schema-helpers'
env = process.env.NODE_ENV || 'local'
config = require('../../../config')

Message = new Schema
  "created": {type: Date, required: false}
  "text": {type: String, required: false}
  "files": [{type: String, required: false}]


Message.plugin schemaHelpers

Message.pre "save", (next) ->
  if @isNew
    @created = new Date()

  next()

module.exports = mongoose.model 'message', Message
