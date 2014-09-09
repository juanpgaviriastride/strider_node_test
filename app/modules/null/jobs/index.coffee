config = require('../../../config')
common = require('../../../config/common')
async = require("async")

_ = require 'underscore'

BaseController = require("null/controller/base")
Job = require "./model"


class JobController extends BaseController
  model: Job

  dispatch: (id, callback) =>
    # Override this method to dispache services usign client lib of each service
    # each app has different services

    return true

  completed: (id, response, callback) =>
    data =
      _id: id
      status: 'complete'
      response: response

    @updateOne(data, callback)

  failed: (id, response, callback) =>
    data =
      _id: id
      status: 'fail'
      response: response

    @updateOne(data, callback)

class CronController extends BaseController
  model: Job.Cron

  exec_succeed: (id, job, callback) =>
    @getOne({_id: id}, (err, res) =>
      res.exec_status = 'succeed'
      res.runs.push job
      @updateOne(res, callback)
    )

  exec_failed: (id, callback) =>
    data =
      _id: id
      exec_status: 'fail'

    @updateOne(data, callback)

  resume: (id, callback) =>
    data =
      _id: id
      status: 'active'

    @updateOne(data, callback)

  stoped: (id, callback) =>
    data =
      _id: id
      status: 'stop'

    @updateOne(data, callback)

  failed: (id, response, callback) =>
    data =
      _id: id
      status: 'fail'
      message: response

    @updateOne(data, callback)

module.exports = JobController
module.exports.Cron = CronController
