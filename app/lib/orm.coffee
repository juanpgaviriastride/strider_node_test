Waterline = require("waterline")
couchdb_adapter = require("sails-couchdb-orm")
config = require("../config")
async = require("async")


class ORM
  getCollections: () ->
    App = require "app"
    Null = require "null"

    collections = {}
    for k,model of App.models
      collections[k] = model # the model exports the collection
    #for k,v of Null.modules
    #  collections[k] = model
    return collections

  models: []
  connections: []

  constructor: (opts) ->
    @initialize(opts)

  initialize: (opts) =>
    @waterline = new Waterline()
    @collections ?= @getCollections()
    @config =
      adapters:
        'default': couchdb_adapter
        couchdb: couchdb_adapter
      connections:
        couchdb:
          adapter: 'couchdb'
          host: config.get('couchdb').host
          database: config.get('couchdb').database
      defaults:
        migrate: 'alter'
      collections: @collections


  start: () =>
    @waterline.initialize @config, (err, res) =>
      @models = res.collections
      @connections = res.connections
      colors = require "colors"
      console.log "ORM".blue, "loaded models: ".yellow, "#{k for k,v of @models}".green, "(check modules/app/index.coffee for reference)".grey
      console.log "ORM".blue, "connections: ".yellow, "#{k for k,v of @connections}".green


class SingletonORM
  orm = null
  constructor: (opts) ->
    orm ?= new ORM(opts)
    return orm

module.exports = new SingletonORM()