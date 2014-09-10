fs = require "fs"
mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId
_ = require 'lodash'
schemaHelpers = require 'null/schema-helpers'
env = process.env.NODE_ENV || 'local'
config = require('../../../config')

Location = new Schema
  "display_name": {type: String, required: false}
  "geo": {
    type: { type: String },
    coordinates: [], # [lng, lat]
    text: { type: String }
  }


Location.plugin schemaHelpers






module.exports = mongoose.model 'location', Location
