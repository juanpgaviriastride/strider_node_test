BaseResource = require "null/api/base"
Jobs = require "app/jobs"

class JobResource extends BaseResource
  controller_class: Jobs

  create: (request, response, next) =>
    @request = request
    @response = response

    job_request =
      service: request.body.service
      data: request.body.data
      user: request.user._id

    @controller.dispatch(job_request, (err, job) =>
      return @BadRequest() if err
      @response_detail(job)
    )


class CronJobResource extends BaseResource
  controller_class: Jobs.Cron

module.exports = JobResource
module.exports.CronJobResource = CronJobResource
