fs = require "fs"
config = require('../../../config')
Waterline = require("waterline")

Message = Waterline.Collection.extend(
  identity: 'message'
  connection: 'couchdb'

  attributes: {
    id: { type: 'string', primaryKey: true, unique: true }
    "text": {type: 'string', required: false}
    "asset_ids": {type: 'array' }
    "from_user_id": {type: 'string' }
    "to_user_id": {type: 'string' }
  }
)

module.exports = Message
