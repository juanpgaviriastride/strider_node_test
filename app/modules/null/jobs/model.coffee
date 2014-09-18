fs = require "fs"
_ = require 'lodash'
config = require('../../../config')

Waterline = require("waterline")


Job = Waterline.Collection.extend(
  identity: 'job'
  connection: 'couchdb'

  attributes:{
    "service": {type: 'string' }
    "data": {type: 'json'}
    "status": {type: 'string', defaultTo: 'new' }
    "user": {model: 'user'}
    "response": {type: 'json'}
  }
)



# cron model
Cron = Waterline.Collection.extend(
  identity: 'cron_job'
  connection: 'couchdb'

  attributes:{
    "service": {type: 'string' }
    "schedule": {type: 'json'}
    "data": {type: 'json'}
    "status": {type: 'string', defaultTo: 'active' }
    "message": {type: 'json'}
    "runs": {type: 'array'}
    "user": {model: 'user'}
    "exec_status": {type: 'string'}

  }
)


module.exports = Job
module.exports.Cron = Cron
