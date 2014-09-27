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
    @routers.push new App.Routers.Common

    if window.rootBase == "/test-api"
      @routers.push new App.Routers.TestApi
    else
      @routers.push new App.Routers.Index

    # evetns
    @events = new App.Events.Events()

    # load meModel
    @me = new App.Models.Me($.cookies.get('user'))
    # load the conversation list
    #@conversations = new

    # load new_mesage modal
    # to show call app.new_meesage.show()
    # to hide call app.new_meesage.hide()
    #@new_message = new App.Views.Chats.NewMessage({el: 'div[data-role=modal-container]'})

    # load roster
    @roster = new App.Views.Chats.Roster({el: '[data-role=roster]'})


    @loadXMPP()
    @onLoaded()

  onLoaded: =>
    Backbone.history.start({pushState: false, root: window.rootBase})

  loadXMPP: () =>
    # replace toke 123 for the aut_token when the prosody allowto auth with bearer token
    token = (if $.cookies.get('xmpp_token') then "#{$.cookies.get('xmpp_token')}" else "123")
    @xmpp = new App.XMPP.Client({username: $.cookies.get('user').username, token: token})

$(document).ready ->
  window.app = new App.Initialize
    debug: 3
    environment: 'development'

  app.init()
