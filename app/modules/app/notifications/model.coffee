mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId
_ = require 'lodash'
common = require "../../../config/common"
schemaHelpers = require 'null/schema-helpers'

Notification = new Schema
  user_id : {type: ObjectId, index: {unique: false}}
  message : {type: Number, required: true}
  state   : {type: Number, default: common.NOTE_STATES.normal}
  resource: String
  resource_id : {type: ObjectId, required: true}

# add helpers (shorthands) to current Schema
Notification.plugin schemaHelpers

module.exports = mongoose.model 'notification', Notification
