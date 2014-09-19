Waterline = require "waterline"
jwt = require "jwt-simple"
config = require "../../../config"


AuthToken = Waterline.Collection.extend(
  identity: 'authToken'
  connection: 'couchdb'

  attributes:
    id: { type: 'string', primaryKey: true, unique: true }
    token:       {type: 'string'}
    user_id:     {type: 'string', required: no}
    user_type:   {type: 'string'}
    scope:       {type: 'array'}#[{type: 'string'}]


  beforeCreate: (values, next) =>
    console.log "BEFORE CREATE TOKEN"
    context =
      scope: values.scope
      user_id: values.user_id
      user_type: values.user_type
      timestamp: (new Date()).toISOString
    values.token = jwt.encode(context, config.get("auth_token_secret"))
    next()
)

module.exports = AuthToken
