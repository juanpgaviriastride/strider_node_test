orm = require "../../../lib/orm"
BaseManager = require("null/models/base_manager")


class PatientController extends BaseManager
  model_identifier: 'patient'


module.exports = PatientController
