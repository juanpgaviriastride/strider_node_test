passport = require "passport"
mongoose = require "mongoose"

express = require "express"
app = module.exports = express()
colors = require "colors"


Users = require("app/users")
Devices = require("app/devices")
AuthToken = require("app/auth_token")
LocalStrategy = require('passport-local').Strategy
BearerStrategy = require('passport-http-bearer').Strategy


passport.use(new LocalStrategy(
  {
    usernameField: 'username',
    passwordField: 'password',
    passReqToCallback: true,
  },
  (request, username, password, done) ->
    process.nextTick( () ->
      users = new Users()
      users.getOne({username: username}, (err, user) ->
        return done(err, false, { message: 'Authentication fail'}) if err
        return done({status: 401, message: 'Authentication fail'}, false, { message: 'Authentication fail'}) unless user


        if not user.authenticate(password)
          return done(null, false, {message: 'Invalid password'})


        authToken = new AuthToken()
        authToken.get_or_create {user_id: user.id, user_type: 'user'}, (error, result) ->
          return done(error, null) if error
          if result is null
            error = new Error("Something went wrong getting the AuthToken")
            error.status = 500
            return done(error,null)
          else
            console.log "Authenticated!".green, user, result.token
            user = user.toJSON()
            delete user.hashed_password
            user.token = result.token
            return done(null, user)

      )
    )
  )
)

passport.use(new BearerStrategy(
  (token, done) ->
    process.nextTick( () ->
      authToken = new  AuthToken()
      authToken.verify(token, (error, token) ->
        return done(error, false, { message: 'Authentication fail'}) if error
        return done(null, false, { message: 'Authentication fail'}) unless (token)

        switch token.user_type
          when "user"
            users = new Users()
            users.getOne({_id: token.user_id}, (err, result) ->
              return done(err, false, { message: 'Authentication fail'}) if err
              return done(null, false, { message: 'Authentication fail'}) unless result

              done(null, result)
            )
          when "device"
            devices = new Devices()
            devices.getOne({_id: token.user_id}, null, {user: []}, (err, result) ->
              return done(err, false, { message: 'Authentication fail'}) if err
              return done(null, false, { message: 'Authentication fail'}) unless result

              done(null, result.user)
            )
          else
            error =
              message: "Invalid token type"
              error: 400
            done(error, null)

      )

    )
  )
)

# passport.ensureAuthenticated = (request, response, next) ->
#   return next() if request.isAuthenticated()
#   response.status(401).json({error: 401, message: "Unauthorized"})


# module.exports = passport

passport.serializeUser (user, done) ->
  console.log "Serialized user: ", user
  done null, user.token

passport.deserializeUser (user, done) ->
  done null, user


app.post '/auth/local', passport.authenticate('local'), (req, res, next) ->
  # stay login for 3 weeks
  console.log "post /auth/local auth local : ", req.isAuthenticated()
  console.log "stay_login : ", req.user
  if req.param('stay_login')
    req.session.cookie.expires = false
    req.session.cookie.maxAge = 86400000*21
  res.json req.user
