BaseServiceServer = require "null/service/base_server"
config = require("../../../config")

# DLS queries helper
_ = require "underscore"
moment = require "moment"
Job = require("app/jobs")
async = require "async"
schedule = require('node-schedule')



class Cron extends BaseServiceServer
  queue: 'Cron'

  # type is not in use right now :P
  type: 'fanout'
  initialize: (options) =>
    @crons = []
    @cronsScheduled = {}
    super

  run: () =>
    super
    @loadCronJobs()

  process: (job) =>
    @job = job
    queue = "jobs"
    message = job
    @redisPublish(queue, message)

    switch job.data[0].action
      when "create"
        @createCron(job, (err, res) =>
          console.log "Cron created", err, res
          return @fail(err) if err
          @scheduleJob(res) if res
          @response('scheduled')
        )
      when "stop"
        if @cronsScheduled[job.data[0]?.cron]?
          @cronsScheduled[job.data[0].cron].cancel()
        cron = new Job.Cron()
        cron.stoped(job.data[0].cron, (err, res) =>
          return @fail(err) if err
          @response('stoped') if res
        )
      when "resume"
        cron = new Job.Cron()
        cron.resume(job.data[0].cron, (err, res) =>
          return @fail(err) if err
          @scheduleJob(res) if res
          @response('resume') if res
        )
      when "delete"
        if @cronsScheduled[job.data[0]?.cron]?
          @cronsScheduled[job.data[0].cron].cancel()
          delete @cronsScheduled[job.data[0].cron]

        cron = new Job.Cron()
        cron.deleteOne({_id: job.data[0].cron}, (err, res) =>
          return @fail(err) if err
          @response('deleted') if res
        )
      else
        err = {
          error: 400
          message: "action needed"
        }
        return @fail(err)
    return

  response: (result) =>
    jobs = new Job()
    response =
      results: result

    jobs.completed(@job._id, response, (err, res) =>
      queue = "jobs"
      message = res
      @redisPublish(queue, message)
    )

  fail: (message) =>
    jobs = new Job()
    jobs.failed(@job._id, message, (err, res) =>
      queue = "jobs"
      message = res
      @redisPublish(queue, message)
    )

  createCron: (job, callback) =>
    cron = new Job.Cron()
    data =
      service: job.data[0].service
      schedule: job.data[0].schedule
      data: job.data[0].data
      status: 'active'
      user: job.user

    cron.create(data, (err, res) =>
      @crons.push res unless err
      return callback(err, res) if typeof callback == "function"
    )

  loadCronJobs: () =>
    cron = new Job.Cron()
    query =
      status: "active"

    cron.filter(query, (err, results) =>
      _.each results.queryset, (item) =>
        @scheduleJob(item)
    )

  scheduleJob: (cron, callback) =>
    console.log "Scheduling job: "
    rule = {}
    for key, value of cron.schedule
      if typeof value == "array"
        rule[key] = _.map value, (item) ->
          return parseInt item
      else if typeof value == "string"
        rule[key] = parseInt value
    if _.keys(rule).length > 0
      @cronsScheduled[cron._id] = schedule.scheduleJob(rule, ->
        job_request =
          service: cron.service
          data: cron.data
          user: cron.user

        (new Job()).dispatch(job_request, (err, res) =>
          Cron = new Job.Cron()
          return Cron.exec_failed(cron._id, (error, result) =>
            callback(error, result) if typeof callback == "function"
          ) if err
          Cron.exec_succeed(cron._id, res, (error, result) =>
            callback(error, result) if typeof callback == "function"
          )
        )
      )
    else
      msg = {err: 400, message: "Bad schedule params"}
      @cron.failed(cron._id, msg)
      callback(true, null) if typeof callback == "function"




module.exports = Cron
