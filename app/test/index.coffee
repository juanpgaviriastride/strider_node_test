assert = require("assert")
should = require("should")
db = require("../lib/db")
async = require("async")
config = require("../config")

global.url= "http://#{config.get('app').host}:#{config.get('app').port}"

before( (done) ->
  this.timeout(20000)
  console.log "DB: ", db.name
  return false unless db.name in ["cs_test", "cs_integration"]
  setTimeout( () ->
    async.series({
      delete_db: (callback) ->
        db.db.dropDatabase( (err) ->
          if err
            console.log "Error while deleting the db #{db.name}:", err
            callback(err, null)
          else
            console.log "Database #{db.name} deleted"
            callback(null, true)
        )
    },
    (err, results) ->
      if err
        return false
      done()
    )
  ,1500)
)

require("./test_controllers")
require("./test_api")
