# Null jobs
JobController = require("null/jobs")

# App services clients
CronJobClient = require "services/cron_jobs/client"

class TMSJobController extends JobController

  dispatch: (job_request, callback) =>

    return callback({err: 400, message: "Bad request"}, null) if not job_request?.user?
    data = {}
    data = job_request.data if job_request.data?
    data.date = new Date()

    switch job_request.service
      when "cron_job"
        service = new CronJobClient({user: job_request.user})
      else
        return callback({err: 400, message: "Bad request no service found"}, null)

    service.run(data, (error, job) =>
      return callback(error, job)
    )

module.exports = TMSJobController
module.exports.CronJobResource = JobController.CronJobResource
