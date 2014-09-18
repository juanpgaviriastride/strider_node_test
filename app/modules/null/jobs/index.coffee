config = require('../../../config')
common = require('../../../config/common')
async = require("async")

_ = require 'underscore'

orm = require "../../../lib/orm"
BaseManager = require("null/models/base_manager")


class JobController extends BaseManager
  model_identifier: 'job'

  dispatch: (id, callback) =>
    # Override this method to dispache services usign client lib of each service
    # each app has different services

    return true

  completed: (id, response, callback) =>
    data =
      id: id
      status: 'complete'
      response: response

    @updateOne(data, callback)

  failed: (id, response, callback) =>
    data =
      id: id
      status: 'fail'
      response: response

    @updateOne(data, callback)

class CronController extends BaseManager
  model_identifier: 'cron_job'

  exec_succeed: (id, job, callback) =>
    @getOne({id: id}, (err, res) =>
      res.exec_status = 'succeed'
      res.runs.push job
      @updateOne(res, callback)
    )

  exec_failed: (id, callback) =>
    data =
      id: id
      exec_status: 'fail'

    @updateOne(data, callback)

  resume: (id, callback) =>
    data =
      id: id
      status: 'active'

    @updateOne(data, callback)

  stoped: (id, callback) =>
    data =
      id: id
      status: 'stop'

    @updateOne(data, callback)

  failed: (id, response, callback) =>
    data =
      id: id
      status: 'fail'
      message: response

    @updateOne(data, callback)

module.exports = JobController
module.exports.Cron = CronController
