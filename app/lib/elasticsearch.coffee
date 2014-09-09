config = require('../config')

ElasticSearch = require('elasticsearch');

serverOptions = {
  hosts: config.get('elasticsearch').hosts,
  secure: false,
}

module.exports = new ElasticSearch.Client(serverOptions)

module.exports.deleteIndex = (callback) ->
  es = new ElasticSearch.Client(serverOptions)
  es.deleteIndex(config.get('elasticsearch').index_name, callback)
