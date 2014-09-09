fs = require "fs"
mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId
_ = require 'lodash'
schemaHelpers = require 'null/schema-helpers'
config = require('../../../config')

Comment = new Schema
  created: { type: Date, default: Date.now }
  text: { type: String }

  resource_type: String
  resource_id      : { type: String, index: {unique: false}}
  user      : { type: Schema.Types.ObjectId, ref: 'user', index: {unique: false}}




Comment.plugin schemaHelpers


module.exports = mongoose.model 'comment', Comment
