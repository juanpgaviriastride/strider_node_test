BaseResource = require "null/api/base"
Patient = require "app/patients"

class PatientResource extends BaseResource
  controller_class: Patient
  populate: {}


module.exports = PatientResource
