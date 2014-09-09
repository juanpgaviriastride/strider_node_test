fs = require "fs"
mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId
_ = require 'lodash'
schemaHelpers = require 'null/schema-helpers'
config = require('../../../config')

Job = new Schema
  # customer contact
  created       : {type: Date }
  service      : {type: String, required: true}
  data:  Schema.Types.Mixed
  status           : {type: String, default: 'new', required: true}
  user      : { type: Schema.Types.ObjectId, ref: 'user', index: {unique: false}}
  response: Schema.Types.Mixed




#Contact.index({ "company": 1, "customer_no": 1 }, { unique: true })

Job.plugin schemaHelpers

Job.pre 'save', (next) ->
  # sort_date == origin_start_time for pending states
  # sort_date == dest_end_t
  if @isNew
    @created = new Date()

  next()


# cron model
Cron = new Schema
  # customer contact
  created       : {type: Date }
  service      : {type: String, required: true}
  schedule:    Schema.Types.Mixed
  data:  Schema.Types.Mixed
  status           : {type: String, default: 'active', required: true}
  message:  Schema.Types.Mixed
  runs: [{ type: Schema.Types.ObjectId, ref: 'job', index: {unique: true}}]
  user: { type: Schema.Types.ObjectId, ref: 'user' }
  exec_status: {type: String}


#Contact.index({ "company": 1, "customer_no": 1 }, { unique: true })

Cron.plugin schemaHelpers

Cron.pre 'save', (next) ->
  # sort_date == origin_start_time for pending states
  # sort_date == dest_end_t
  if @isNew
    @created = new Date()

  next()

module.exports = mongoose.model 'job', Job
module.exports.Cron = mongoose.model 'cron', Cron
