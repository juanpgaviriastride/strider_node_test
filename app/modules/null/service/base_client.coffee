redis = require("../../../lib/redis")
Job = require("null/jobs")

class BaseServiceClient

  # queue is the name of the queue
  # all the servicces will have prefix 'Serivices'
  # example:
  # queue: 'Reports.daily'
  #
  # the servicie will be: 'Services.Reports.daily'
  queue: null

  # type define the  queue type:
  #   direct
  #   topic
  #   headers
  #   fanout
  type: null

  constructor: (options) ->
    @initialize(options)

  initialize: (options) =>
    @options = options
    @service_queue = "Services.#{@queue}"
    return

  run: (options..., callback) ->
    unless options
      options = {}

    data = {
      service: @service_queue
      data: options
    }
    data.user = @options.user if @options.user?

    job = new Job()
    job.create(data, (error, result) =>
      callback(error, result) if typeof callback == 'function'
      redis.pub.publish(result.service, JSON.stringify(result))
    )
    return @




module.exports = BaseServiceClient
