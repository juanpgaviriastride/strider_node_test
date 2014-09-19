config = require('../../../config')
orm = require "../../../lib/orm"
BaseManager = require("null/models/base_manager")

async = require "async"

class LocationController extends BaseManager
  model_identifier: 'location'



module.exports = LocationController
