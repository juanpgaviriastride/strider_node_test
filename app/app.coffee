express = require "express"
http = require "http"
path = require "path"
fs = require "fs"

async = require "async"

global.root = __dirname

async.series({
  orm: (done) ->
    orm = require "./lib/orm"
    orm.start(done)
  }, (err, res) ->
    return console.log "ERROR: Initializing ORM ", err if err
    webserver = require "webserver"
    webserver.start()

    # Services
    services = require "services"
)
