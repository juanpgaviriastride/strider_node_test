fs = require "fs"
config = require('../../../config')
Waterline = require("waterline")

Message = Waterline.Collection.extend(
  identity: 'message'
  connection: 'couchdb'

  attributes: {
    "text": {type: 'string', required: false}
    "files": {type: 'array' }

  }
)

module.exports = Message
