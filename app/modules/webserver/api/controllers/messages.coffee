BaseResource = require "null/api/base"
Messages = require "app/messages"
_ = require "underscore"

class MessageResource extends BaseResource
  controller_class: Messages
  populate: {}

  list: (req, res, next) =>
    if req.query.conversation == "true" and req.query.from? and req.query.to?
      participants = []

      sort_participants = [req.query.to]
      if _.sortedIndex sort_participants, req.query.from
        participants = [req.query.to, req.query.from]
      else
        participants = [req.query.from, req.query.to]

      req.query.participants = participants.join("-")
      delete req.query.conversation
      delete req.query.to
      delete req.query.from

    super


module.exports = MessageResource
