#config = require('../../config/config')[global.env]
config = require '../../../config'
pkg  = require '../../../package.json'
cons = require "consolidate"
swig = require "swig"

express = require "express"
app = module.exports = express()

# Template engine
#swigHelpers = require('./helpers')
#swigHelpers(swig)


swig.setDefaults({ cache: false })
app.engine('html', swig.renderFile)

Job = require "null/jobs"


app.set('view engine', 'html')
app.set('views', "#{global.root}/modules/webserver/views")
app.set('view cache', false)

app.get '/', (req, res) ->
  debug = (if req.query.debug then req.query.debug else config.get('debug'))

  if req.isAuthenticated()
    debug = (if req.query.debug then req.query.debug else config.get('debug'))
    res.render "index.html", {
      rootBase: '/',
      address: "https://#{config.get('app').host}:#{config.get('app').port}",
      imHost: "#{config.get('app').im?.bosh?.host}",
      imPort: "#{config.get('app').im?.bosh?.port}",
      domain: "#{config.get('app').host}",
      debug: debug
    }

  else
    #console.log "Redirect non auth user to login page"
    #res.redirect "/login"
    debug = (if req.query.debug then req.query.debug else config.get('debug'))
    res.render "login.html", {debug: debug}

app.get '/test-api', (req, res) ->
  debug = (if req.query.debug then req.query.debug else config.get('debug'))

  if req.isAuthenticated()
    debug = (if req.query.debug then req.query.debug else config.get('debug'))
    res.render "test_api.html", {rootBase: '/test-api', address: "https://#{config.get('app').host}:#{config.get('app').port}", debug: debug}
  else
    #console.log "Redirect non auth user to login page"
    #res.redirect "/login"
    debug = (if req.query.debug then req.query.debug else config.get('debug'))
    res.render "login.html", {debug: debug}

app.get '/jobs', (req, res) ->
  if req.isAuthenticated()
    debug = (if req.query.debug then req.query.debug else config.get('debug'))

    crons = new Job.Cron()
    crons.filter({}, (err, results) =>
      res.render "jobs.html", {user: req.user, debug: debug, version: pkg.version, cron_jobs: results.queryset}
    )
  else
    debug = (if req.query.debug then req.query.debug else config.get('debug'))
    res.render "login.html", {debug: debug}

# stanza.io demo
app.get '/test-xmpp', (req, res) ->
  res.render "test-xmpp.html"


app.get '/test-theme', (req, res) ->
  res.render "theme.html"

app.get '/404', (req, res) ->
  res.render "404.html"
