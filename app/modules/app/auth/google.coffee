passport = require "passport"
mongoose = require "mongoose"
GoogleStrategy = require("passport-google-oauth").OAuth2Strategy

express = require "express"
app = module.exports = express()

passport.use new GoogleStrategy {
    clientID: '364734909892.apps.googleusercontent.com',
    clientSecret: 'RJmZHHB_lujpJ_UM8rN-iGyT',
    callbackURL: "http://localhost:3000/oauth2callback"
  },
  (accessToken, refreshToken, profile, done) ->
    console.log "google auth:"
    console.log "   accessToken : #{accessToken}"
    console.log "   refreshToken : #{refreshToken}"
    console.log "   profile : #{profile}"
    return done(null, profile)

app.post '/auth/google', passport.authenticate('google',{scope: ['https://www.googleapis.com/auth/userinfo.profile', 'https://www.googleapis.com/auth/userinfo.email'] }), (req, res) ->
  res.json req.user

app.get '/oauth2callback', passport.authenticate('google'), (req, res) ->
  res.json req.user