winston = require "winston"
require "winston-papertrail"

config = require "../../../config"

logger = new winston.Logger
  exitOnError: no,
  transports: [
    new winston.transports.Console(),
    new winston.transports.Papertrail
      host: config.get('papertrail').host
      port: config.get('papertrail').port
  ]

logger.info "Started logger"

module.exports = logger
