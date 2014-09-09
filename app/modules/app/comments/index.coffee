config = require('../../../config')
common = require('../../../config/common')
async = require("async")
_ = require('underscore')

BaseController = require("null/controller/base")
Model = require "./model"


class CommentController extends BaseController
  model: Model


module.exports = CommentController
