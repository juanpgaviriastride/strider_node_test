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
    # load meModel
    @me = new App.Models.Me($.cookies.get('user'))
    @me_info = new App.Views.Common.Me.Info({el: '[data-role="me-info"]',model: @me})

    # Setup routers
    @routers = []
    @routers.push new App.Routers.Common

    switch window.rootBase
      when "/test-api"
        @routers.push new App.Routers.TestApi()
      when "/admin"
        @routers.push new App.Routers.Admin()
      else
        @routers.push new App.Routers.IM()

    # evetns
    @events = new App.Events.Events()

    @loadXMPP()
    @onLoaded()

  onLoaded: =>
    Backbone.history.start({pushState: false, root: window.rootBase})

  loadXMPP: () =>
    # replace toke 123 for the aut_token when the prosody allowto auth with bearer token
    token = (if $.cookies.get('auth_token') then "#{$.cookies.get('auth_token')}" else "123")
    @xmpp = new App.XMPP.Client({username: $.cookies.get('user').username, token: token})

  loadPage: (view_class, options) =>
    app.current_view.remove() if app.current_view?
    app.current_view = new view_class options
    app.current_view.render()

  setupPage: (view_class, options) =>
    console.log "setup page: ", arguments
    app.current_page.remove() if app.current_page
    app.current_page = new view_class options
    app.current_page.render()

$(document).ready ->
  window.app = new App.Initialize
    debug: 3
    environment: 'development'

  app.init()
