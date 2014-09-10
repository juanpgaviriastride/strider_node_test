BaseResource = require "null/api/base"
Surgeries = require "app/surgeries"

class SurgeryResource extends BaseResource
  controller_class: Surgeries
  populate: {}


module.exports = SurgeryResource
