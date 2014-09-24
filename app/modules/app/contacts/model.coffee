fs = require "fs"

config = require('../../../config')
Waterline = require("waterline")

Contact = Waterline.Collection.extend(
  identity: 'contact'
  connection: 'couchdb'

  attributes:{
    id: { type: 'string', primaryKey: true, unique: true }
    "user": {model: 'user'}
    "contact_id": {model: 'user'}
    "contact_username": { type: 'string' }
    "contact_name": { type: 'string' }
  }
)

module.exports = Contact
