fs = require "fs"
config = require('../../../config')
Waterline = require("waterline")

Message = Waterline.Collection.extend(
  identity: 'message'
  connection: 'couchdb'

  attributes: {
    id: { type: 'string', primaryKey: true, unique: true }
    "body": { type: 'string', required: false}
    "type": { type: 'string' }
    "from": { type: 'string' }
    "to": { type: 'string' }
    "from_jid": { type: 'string' }
    "to_jid": { type: 'string' }
    "timestamp": { type: 'date' }
  }
)

module.exports = Message
