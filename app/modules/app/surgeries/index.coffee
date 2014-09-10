require 'mongoose-pagination'
Model = require "./model"
HTTPStatus = require "http-status"
config = require('../../../config')
async = require "async"
BaseController = require("null/controller/base")
_ = require 'underscore'

class SurgeryController extends BaseController
  model: Model




module.exports = SurgeryController
