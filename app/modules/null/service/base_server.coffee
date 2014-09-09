redis = require("../../../lib/redis")
Job = require("null/jobs")


class BaseServiceServer

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
    @service_queue = "Services.#{@queue}"
    return

  run: (options) ->
    @initRedis()
    return @

  process: (message) ->
    return message

  # redis
  initRedis: () =>
    that = @
    redis.sub.on("pmessage", (pattern, channel, message) =>
      if @service_queue == channel
        data = JSON.parse(message)

        job = new Job()
        job.updateOne {_id: data._id, status: 'progress'}, (err, result) =>
          @process(result)
    )
    @redisSubscribe(@service_queue)
  ,

  redisSubscribe: (queue) =>
    redis.sub.psubscribe(queue)
  ,

  redisUnsubscribe: (queue) =>
    redis.sub.punsubscribe(queue)
  ,

  redisPublish: (queue, message) =>
    redis.pub.publish queue, JSON.stringify(message)
    return

module.exports = BaseServiceServer
