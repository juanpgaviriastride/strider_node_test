fs = require "fs"
mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId
_ = require 'lodash'
schemaHelpers = require 'null/schema-helpers'
env = process.env.NODE_ENV || 'local'
config = require('../../../config')

Patient = new Schema
  "ssn":  {type: String, required: false},
  "ehr": {
    "ehr": {type: String, required: false},
    "id": {type: String, required: false},
  },
  "name": {
    "prefix": {type: String, required: false},
    "first":  {type: String, required: false},
    "middle": {type: String, required: false},
    "last":  {type: String, required: false}
  },
  "dob":  {type: Date, required: false},
  "profileUrl":  {type: String, required: false},
  "contactInfo": {
    "phone":{
      "office":  {type: String, required: false}
      "cell":  {type: String, required: false}
    },
    "email":{
      "personal":  {type: String, required: false}
      "work":  {type: String, required: false}
    }
  }

  "allergies":[{type: String, required: false}],
  "currentMedications":[{type: String, required: false}],
  "procedures":[{type: String, required: false}],
  "currentLocation": { type: Schema.Types.ObjectId, ref: 'location' }

Patient.plugin schemaHelpers

Patient.pre "save", (next) ->
  if @isNew
    @dob = new Date()

  next()





module.exports = mongoose.model 'patient', Patient
