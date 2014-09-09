util = require 'util'
NotModifiedError = (message, constr) ->
  Error.captureStackTrace(@, constr || @)
  @message = message || 'Doc not Modified'

util.inherits NotModifiedError, Error
NotModifiedError.prototype.name = 'Not Modified'

exports.NotModifiedError = NotModifiedError