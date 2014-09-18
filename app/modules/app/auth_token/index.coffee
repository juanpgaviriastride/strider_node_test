BaseManager = require("null/models/base_manager")


class AuthTokenController extends BaseManager
  model_identifier: 'authtoken'

  get_or_create: (options, callback) =>
    @model.findOne().where(user_id: options.user_id, user_type: options.user_type).exec (err, res) =>
      return callback(err, null) if err
      if res?
        callback(null, res)
      else
        context =
          user_id: options.user_id
          user_type: options.user_type

        token = @model.create(user_id: options.user_id, user_type: options.user_type, scope: ['api'])
        token.exec (error, result) =>
          return callback(error, result)

  verify: (token, callback) =>
    @model.findOne().where(token: token).exec (error, result) ->
      console.log "VERIFY: ", error, result
      return callback(error, null) if error?
      callback(null, result)


module.exports = AuthTokenController
