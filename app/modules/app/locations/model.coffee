fs = require "fs"

config = require('../../../config')
Waterline = require("waterline")

Location = Waterline.Collection.extend(
  identity: 'location'
  connection: 'couchdb'

  types: {
    point: (location) ->
      console.log "Location: ", location
      return true if location.type? and location.coordinates? and location.text?
      return false
    ,
  }

  attributes:{
    "display_name": {type: 'string', required: false}
    "geo": {type: 'json', point: true}
  }
)

module.exports = Location
