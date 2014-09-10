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
  "name": {
    "prefix": {type: String, required: false},
    "first":  {type: String, required: false},
    "last":  {type: String, required: false}
  },
  "dob":  {type: String, required: false},
  "profileUrl":  {type: String, required: false},
  "role":  {type: String, required: false},
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

Patient.plugin schemaHelpers






module.exports = mongoose.model 'patient', Patient
