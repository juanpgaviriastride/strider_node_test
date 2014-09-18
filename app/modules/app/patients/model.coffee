fs = require "fs"
config = require('../../../config')
Waterline = require("waterline")

Patient = Waterline.Collection.extend(
  identity: 'patient'
  connection: 'couchdb'

  types: {
    ehr: (ehr) ->
      return true if ehr.ehr? and ehr.id?
      return false
    name: (name) ->
      return true if name.prefix? or name.first? or name.middle? or name.last?
      return false
    contactInfo: (contactInfo) ->
      return true if contactInfo.phone? or contactInfo.email?
      return false
  }

  attributes: {
    "ssn":  {type: 'string'},
    "ehr": {type: 'json', ehr: true}
    "name": {type: 'json', name: true}

    "profileUrl":  {type: 'string'},
    "contactInfo": {type: 'json', contactInfo: true}
    "allergies": {type: 'array'},
    "currentMedications":{type: 'array'},
    "procedures": {type: 'array' },

    "currentLocation": { model: 'location' },
  }
)


module.exports = Patient
