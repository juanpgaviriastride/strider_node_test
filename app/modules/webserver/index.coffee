# Configuration
http = require("http")
express = require("express")
fs = require("fs")
path = require("path")
config = require("../../config")
RedisStore = require('connect-redis')(express)


redis = require("../../lib/redis")
# WIP: mongoose is being replaced by a waterline couchdb adapter
#db = require("../../lib/db")


# Mailer
mailer = require('../../lib/mailer')
mailer.setTemplateRoot(path.join __dirname, './views/emails')
mailer.setTemplateExt('.html')
mailer.compile()


# express app
app = express()

express.request.redis = redis

cookieParser = express.cookieParser("^^t$:w<-c9fSK&&YAS3A;)#op-$6nH\)<{)zvtc5{JO6a0j/Z5")
sessionConf =
  secret: "X:o>&O-/o\QsIa~@n))sQ|ON(x|KV0u?$+H`Y:Oi3n!0i:V2z"
  store: new RedisStore
    host: config.get('redis').host,
    port: config.get('redis').port,
    db: 2,
    pass: config.get('redis').options.auth


app.configure ->
  #app.use express.favicon(path.join __dirname, './public/favicon.ico')
  app.use express.logger("dev")
  app.use express.bodyParser({limit: '50mb', keepExtensions: true, uploadDir: path.join(global.root, config.get('media_root'))})
  app.use express.urlencoded()
  app.use express.json()
  app.use express.methodOverride()
  app.use cookieParser
  app.use express.session(sessionConf)

  parseDebug = () ->
    return (req, res, next) ->
      if req.query.debug?
        if req.query.debug == "false"
          req.query.debug = no
        else if req.query.debug == "true"
          req.query.debug = yes
      next()

  app.use(parseDebug())

  app.use app.router
  app.use express.static(path.join(__dirname, "public"))

  # mount applications
  app.use require "app/auth/passport_setup"
  app.use '/api/v1', require("app/auth")
  app.use require "./static_pages"
  app.use require "./api"



# express app configuration for dev env
app.configure "development", ->
  app.use express.errorHandler(
    dumpExceptions: false
    showStack: false
  )

# express app configurarion for pro env
app.configure "production", ->
  app.use express.errorHandler()


# *******************************************************
start = () ->
  console.log "starting PORT: #{process.env.PORT} | #{config.get('app').port}"
  if process.env.PORT != undefined
    port = process.env.PORT
  else
    port = config.get('app').port
  server = http.createServer(app)
  server.listen(port, () ->
    console.log "Express server listening on port " + port
  )

  require("app/push-manager").init(server, sessionConf, cookieParser)

exports.start = start
exports.app = app
