fs = require "fs"
mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId
_ = require 'lodash'
schemaHelpers = require 'null/schema-helpers'
env = process.env.NODE_ENV || 'local'
config = require('../../../config')

Surgery = new Schema
  "ssn":  {type: String, required: false},
  "display_name": {type: String, required: false}
  "time":{
    "start": {type: Date, required: false},
    "end": {type: String, required: false}
  },
  "patientId":{ type: Schema.Types.ObjectId, ref: 'patient' },
  "teamIds":[
    {
      "role": {type: String, required: false},
      "staffId": {type: String, required: false}
    }
  ],
  "location": { type: Schema.Types.ObjectId, ref: 'location' },
  "status": {type: String, required: false},

Surgery.plugin schemaHelpers






module.exports = mongoose.model 'surgery', Surgery
