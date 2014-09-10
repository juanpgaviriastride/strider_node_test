BaseResource = require "null/api/base"
Messages = require "app/messages"

class MessageResource extends BaseResource
  controller_class: Messages
  populate: {}


module.exports = MessageResource
