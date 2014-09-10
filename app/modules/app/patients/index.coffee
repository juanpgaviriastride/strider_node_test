require 'mongoose-pagination'
Model = require "./model"
HTTPStatus = require "http-status"
config = require('../../../config')
async = require "async"
BaseController = require("null/controller/base")
_ = require 'underscore'

class PatientController extends BaseController
  model: Model




module.exports = PatientController
