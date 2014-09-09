class App.Initialize
  debug: 0 # debug levels
  environment: 'development' # development | production

  constructor: (options) ->
    @routes = []
    _.extend @, options
    _.extend @, Backbone.Events

  init: =>
    # Initialize main models
    @user = new App.Models.User($.cookies.get('user'))
    #@user.id =

    @users = new App.Collections.Users
    @users.push @user

    # @socket = io.connect window.address
    # @socket.on "job", (data) ->
    #   console.log data

    @onLoad()

  onLoad: =>
    # Setup routers
    @routers = []
    @routers.push new App.Routers.Index
    @routers.push new App.Routers.TestApi

    @onLoaded()

  onLoaded: =>
    Backbone.history.start({pushState: false, root: window.rootBase})

$(document).ready ->
  window.app = new App.Initialize
    debug: 3
    environment: 'development'

  app.init()
