BaseServiceClient = require "null/service/base_client"

class Cron extends BaseServiceClient
  queue: 'Cron'
  # type is not in use right now :P
  type: 'fanout'


module.exports = Cron
