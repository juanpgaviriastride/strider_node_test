conf = require('../config')
nano = require 'nano'

module.exports = (database) ->
  # connect to CouchDB via nano
  schema = 'http'
  auth = ''
  host = conf.get('couchdb').host
  port = conf.get('couchdb').port
  nano([schema, '://', auth, host, ':', port, '/'].join('')).use(database)
