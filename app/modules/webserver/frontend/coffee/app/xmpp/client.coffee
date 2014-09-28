class App.XMPP.Client
  constructor: (opt) ->
    @initialize(opt)

  initialize: (opt) =>
    @connected = false
    @username = opt.username
    @token = opt.token
    console.log opt

    @xmpp = XMPP.createClient(
      jid: "#{@username}@#{imConfig.host}"
      password: @token
      wsURL: "ws://#{imConfig.host}:#{imConfig.port}/xmpp-websocket"
      #boshURL: boshURL
      transports: ['old-websocket']
    )

    @xmpp.once "session:started", @onSessionStarted

    # manage subscirpts
    @xmpp.on "subscribe", @onSubscribe
    @xmpp.on "subscribed", @onSubscribed
    @xmpp.on "message:sent", @onMessageSent
    @xmpp.on "chat", @onChat

    @connect()

  onSessionStarted: () =>
    console.log "session started"
    @connected  = true
    @xmpp.enableCarbons (err) =>
      console.log "Server does not support carbons"  if err
      return

    @xmpp.getRoster (err, resp) =>
      console.log "ROSTER: ", resp
      app.me.loadRoster(resp)
      @xmpp.updateCaps()
      @xmpp.sendPresence caps: @xmpp.disco.caps
      return

    return

  # Methods
  connect: () =>
    return if @connected
    @xmpp.connect()

  sendSubscription: (username) =>
    console.log "Sending subscribe"
    jid = "#{username}@#{imConfig.host}"
    @xmpp.subscribe(jid)


  acceptSubscription: (username) =>
    console.log "Accepeting subscirpt"

    jid = "#{username}@#{imConfig.host}"
    @xmpp.acceptSubscription(jid)
    @sendSubscription(username)

  rejectSubscription: (username) =>
    console.log "Rejecting subscirpt"

    jid = "#{username}@#{imConfig.host}"
    @xmpp.denySubscription(jid)

  sendMessage: (username, message) =>
    to = "#{username}@#{imConfig.host}"
    @xmpp.sendMessage({
      to: to
      body: message
    })


  # Events
  onSubscribe: (data) =>
    # call when the user receive a subscibe
    console.log "Subscribe revice", data
    app.me.addContactRequest(data)

  onSubscribed: (data) =>
    console.log "Subscied to: ", data
    @acceptSubscription(data.from.local)


  onChat: (msg) =>
    msg = msg.toJSON() if msg.toJSON?
    console.log "MESSAGE: ", msg

    app.me.addMessage(msg)


  onMessageSent: (data) =>
    console.log "MESSAGE SENT: ", data
    data.from.bare = app.me.jid
    app.me.addMessage(data)
