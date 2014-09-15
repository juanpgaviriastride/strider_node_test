express = require "express"
http = require "http"
path = require "path"
fs = require "fs"

global.root = __dirname

orm = require "./lib/orm"
orm.start()

webserver = require "webserver"
webserver.start()

# Services
services = require "services"
