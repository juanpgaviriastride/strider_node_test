fs = require "fs"
config = require('../../../config')
Waterline = require("waterline")

Surgery = Waterline.Collection.extend(
  identity: 'surgery'
  connection: 'couchdb'

  types: {
    time: (time) ->
      return true if time.start? or time.end?
      return false
    team: (team) ->
      console.log "Surgery team", team
      return true
      # TODO: validate team objects with this keys
      # [
      #   {
      #     "role": {type: String, required: false},
      #     "staffId": {type: String, required: false}
      #   }
      # ]
  }

  attributes: {
    id: { type: 'string', primaryKey: true, unique: true }
    "ssn":  {type: 'string', required: false},
    "display_name": {type: 'string', required: false}
    "time": {type: 'json', time:true }
    "patientId": { model: 'patient' },
    "teamIds": {type: 'array', team: true },
    "location": { model: 'location' },
    "status": {type: 'string', required: false},
  }
)

module.exports = Surgery
