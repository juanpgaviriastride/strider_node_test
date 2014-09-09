BaseResource = require "null/api/base"
Comments = require "app/comments"


class CommentResource extends BaseResource
  controller_class: Comments
  populate:
    "broker": ['-password']
    "company": []

  create: (req, res, next) =>
    req.body.broker = req.user._id
    super

module.exports = CommentResource
