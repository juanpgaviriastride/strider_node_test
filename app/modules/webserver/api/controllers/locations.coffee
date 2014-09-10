BaseResource = require "null/api/base"
Locations = require "app/locations"

class LocationResource extends BaseResource
  controller_class: Locations
  populate: {}


module.exports = LocationResource
