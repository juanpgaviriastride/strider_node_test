fs = require "fs"
config = require('../../../config')
Waterline = require("waterline")

Message = Waterline.Collection.extend(
  identity: 'message'
  connection: 'couchdb'

  attributes: {
    id: { type: 'string', primaryKey: true, unique: true }
    "body": { type: 'json', required: false}
    "type": { type: 'string', defaultsTo: "normal" }
    "from": { type: 'string' }
    "to": { type: 'string' }
    "from_jid": { type: 'string' }
    "to_jid": { type: 'string' }
    "packet_id": { type: 'string' }
    "timestamp": { type: 'datetime' }
    "participants": {type: 'string'}
  }
)

module.exports = Message
