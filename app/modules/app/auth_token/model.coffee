Waterline = require "waterline"
jwt = require "jwt-simple"
config = require "../../../config"


AuthToken = Waterline.Collection.extend(
  identity: 'authToken'
  connection: 'couchdb'

  attributes:
    token:       {type: 'string'}
    user_id:     {type: 'string', required: no}
    user_type:   {type: 'string'}
    scope:       {type: 'array'}#[{type: 'string'}]

##### To migrate to manager
#
## get or create method
# authTokenSchema.statics.get_or_create = (options, callback) ->
#   @findOne {"user_id": options.user_id, "user_type": options.user_type}, (error, result) ->
#     return callback(error, null) if error
#     if result is null
#       context =
#         user_id: options.user_id
#         user_type: options.user_type

#       token = new AuthToken({user_id: options.user_id, user_type: options.user_type, scope: ['api']})
#       token.save (error,result) ->
#         return callback(error, null) if error
#         return callback(null,result)
#     else
#       callback(null, result)

# ## verify method
# authTokenSchema.statics.verify = (token, callback) ->
#   @findOne({token: token}, (error, result) ->
#     return callback(error, null) if error
#     if result == null
#       callback(null, null)
#     else
#       callback(null, result)
#   )

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
