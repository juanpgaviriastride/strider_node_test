fs = require "fs"
mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId
_ = require 'lodash'
schemaHelpers = require 'null/schema-helpers'
env = process.env.NODE_ENV || 'local'
config = require('../../../config')

Message = new Schema
  "text": {type: String, required: false}
  "files": [{type: String, required: false}]


Message.plugin schemaHelpers






module.exports = mongoose.model 'message', Message
