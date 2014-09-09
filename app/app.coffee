express = require "express"
http = require "http"
path = require "path"
fs = require "fs"

#global.env = env
global.root = __dirname

#config = require "tms/config"

#routes = require("./routes/api")

###
# Static routes
###

webserver = require "webserver"


webserver.start()


# Services
services = require "services"
