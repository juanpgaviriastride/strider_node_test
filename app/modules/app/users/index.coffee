config = require('../../../config')
orm = require "../../../lib/orm"

BaseManager = require("null/models/base_manager")


class UserController extends BaseManager
  model_identifier: 'user'

module.exports = UserController
