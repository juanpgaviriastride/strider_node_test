orm = require "../../../lib/orm"
BaseManager = require("null/models/base_manager")
_ = require "underscore"

class MessageController extends BaseManager
  model_identifier: 'message'

  updateOne: (params..., callback) =>
    [data, options] = params
    data.participants = []

    sort_participants = [data.to.split('@')[0]]
    if _.sortedIndex sort_participants, data.from.split('@')[0]
      data.participants = [data.to.split('@')[0], data.from.split('@')[0]]
    else
      data.participants = [data.from.split('@')[0], data.to.split('@')[0]]

    data.participants = data.participants.join("-")
    @getOne {id: data.id}, (err, result) =>
      return @create(data, callback) unless result
      return super data, options, callback


module.exports = MessageController
