BaseResource = require "null/api/base"
User = require "app/users"

class UserResource extends BaseResource
  controller_class: User
  fields: ['-salt', '-password', '-hashed_password', '-apn_token']

  list: (req,res, next) =>
    console.log "=============================="
    console.log "LOGIN AS: ", req.user
    console.log "=============================="
    super


module.exports = UserResource
