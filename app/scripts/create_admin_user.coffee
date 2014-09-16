if process.env.NODE_ENV == "undefined"
  process.env.NODE_ENV = "dev"

config = require("../config")

orm = require "../lib/orm"
orm.start()

User = require("app/users")

prompt = require('prompt')

prompt.start()

prompt.get([
  {
    name: 'full_name',
    required: true
    type: 'string'
  },
  {
    name: 'username',
    required: true
    type: 'string'
  },
  {
    name: 'email'
    required: true
    message: 'Invalid email'
    type: 'string'
    pattern: /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
  },
  {
    name: 'password',
    hidden: true,
    type: 'string'

  }]
  ,
  (err, result) ->
    result.type = "Admin"
    user = new User()
    result.role = "admin"
    admin = user.create(result, (error, result) ->
      if error
        return console.log "ERROR: Error occured while creating admin user"
      console.log "SUCCESS: Admin user created"
      console.log "Press Ctrl+C to quit"
    )
)
