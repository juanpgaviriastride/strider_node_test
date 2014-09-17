orm = require "../../../lib/orm"
BaseManager = require("null/models/base_manager")


class MessageController extends BaseManager
  model_identifier: 'message'


module.exports = MessageController
