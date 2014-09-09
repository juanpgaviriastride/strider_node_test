config = require('../config')
mongoose = require('mongoose')

# connect to mongodb database
mongoose.connect("mongodb://#{config.get('mongo').host}:#{config.get('mongo').port}/#{config.get('mongo').db}")

db = mongoose.connection

db.on('error', (error) ->
  console.log "Mongo connection error: ", error
)
db.once('open', () ->
  console.log "Mongo connection success"
)

module.exports = db