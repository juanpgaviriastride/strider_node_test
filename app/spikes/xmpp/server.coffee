xmpp = require("node-xmpp-server")
c2s = new xmpp.C2SServer(
  port: 5222
  domain: "localhost"
)

# On Connect event. When a client connects.
c2s.on "connect", (client) ->
  c2s.on "register", (opts, cb) ->
    console.log "REGISTER"
    cb true

  client.on "authenticate", (opts, cb) ->
    console.log "AUTH: " + opts.jid + " -> " + opts.password
    cb null, opts

  client.on "online", ->
    console.log "ONLINE"
    #console.log client.send
    #client.send new xmpp.Message(type: "chat").c("body").t("Hello there, little client.")

  client.on "stanza", (stanza) ->
    console.log "STANZA" + stanza
    #client.send stanza


  client.on "disconnect", (client) ->
    console.log "DISCONNECT"
