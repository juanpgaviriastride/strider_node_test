config = require('../../../config')
orm = require "../../../lib/orm"

BaseManager = require("null/models/base_manager")


class UserController extends BaseManager
  model_identifier: 'user'

  filter: (options..., callback) =>
    [query, fields, populate, page, limit, sort_field, sort_direction] = options

    @model.count({_id: {'!': '_design/views'}}).exec((err, res) =>
      console.log "TEST USER:", err, res
    )
    super

module.exports = UserController
