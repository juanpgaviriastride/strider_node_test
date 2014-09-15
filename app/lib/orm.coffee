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
    for k,v of Null.modules
      collections[k] = model
    return collections

  models: []
  connections: []

  constructor: (opts) ->
    @initialize(opts)

  initialize: (opts) =>
    @waterline = new Waterline()
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

  loadCollection: (collection) =>
    @waterline.loadCollection(collection)

  start: () =>
    that = @
    async.series
       collections: @loadAllCollections
       models: @initializeWaterline
      ,(err, res) ->
        throw err if err
        that.models = res.models.collections
        that.connections = res.models.connections
        console.log "## ORM START"
        console.log "# collections loaded: "
        console.log res.collections
        console.log "# If a collection is missing check that the module index exports the modules array"
        console.log "# Models available: "
        console.log that.models
        console.log "# Connections available: "
        console.log that.connections

        console.log that.waterline


  initializeWaterline: (cb) =>
    that = @
    @waterline.initialize @config, (err, models) ->
      cb(err, models)

  loadAllCollections: (cb) =>
    @collections ?= @getCollections()
    if @collections.length > 0
      throw new Error("Empty collections. Check module index for modules exportation")

    for k,collection of @collections
      @loadCollection collection
    cb(null, @collections)




class SingletonORM
  orm = null
  constructor: (opts) ->
    orm ?= new ORM(opts)
    return orm

module.exports = new SingletonORM()