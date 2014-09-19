fs = require "fs"
config = require('../../../config')
Waterline = require("waterline")

Message = Waterline.Collection.extend(
  identity: 'message'
  connection: 'couchdb'

  attributes: {
    id: { type: 'string', primaryKey: true, unique: true }
    "text": {type: 'string', required: false}
    "files": {type: 'array' }

  }
)

module.exports = Message
