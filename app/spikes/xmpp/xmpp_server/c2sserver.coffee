"use strict"
xmpp = require("node-xmpp-server")

xmpp_core = require("node-xmpp-core")

# This is a very basic C2S server example. One of the key design decisions
#* of node-xmpp is to keep it very lightweight
#* If you need a full blown server check out https://github.com/superfeedr/xmpp-server
#

# Sets up the server.
c2s = new xmpp.C2SServer(
  port: 5222
  domain: "localhost"
)

#     key : "key.pem content",
#     cert : "cert.pem content",
# // or
# tls: {
#     keyPath: './examples/localhost-key.pem',
#     certPath: './examples/localhost-cert.pem'
# }

# On Connect event. When a client connects.
c2s._clients = {}
c2s.on "connect", (client) ->

  # That's the way you add mods to a given server.

  # Allows the developer to register the jid against anything they want
  c2s.on "register", (opts, cb) ->
    console.log "REGISTER"
    cb true
    return


  # Allows the developer to authenticate users against anything they want.
  client.on "authenticate", (opts, cb) ->
    console.log "AUTH" + opts.jid + " -> " + opts.password
    cb null, opts # cb(false)
    return

  client.on "online", ->
    console.log "ONLINE"
    c2s._clients["#{client.jid.user}@#{client.jid.domain}/#{client.jid.resource}"] = client
    c2s._clients["#{client.jid.user}@#{client.jid.domain}"] = client
    c2s._clients["#{client.jid.user}"] = client

    #client.send new xmpp_core.Message(type: "chat").c("body").t("Hello there, little client.")
    return


  # Stanza handling
  client.on "stanza", (stanza) ->
    #console.log "STANZA", stanza
    # console.log "Client: ", client
    # console.log "C2SServer: ", c2s

    if stanza.is("message") and (stanza.attrs.type isnt "error")
      # and send back
      console.log "Sending message to #{stanza.attrs.to} from #{stanza.attrs.from}: ", stanza.getChild('body').getText()
      c2s._clients[stanza.attrs.to].send new xmpp_core.Message(type: "chat", from: stanza.attrs.from).c("body").t(stanza.getChild('body').getText())

    return


  # On Disconnect event. When a client disconnects
  client.on "disconnect", ->
    console.log "DISCONNECT"
    return

  return
