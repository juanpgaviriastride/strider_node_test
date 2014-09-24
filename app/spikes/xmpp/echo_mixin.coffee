###
Demonstrates how the echo behavior can be abstracted into a decorator,
working equally well on clients, components or S2S.
###

echoMixin = (connection) ->
  connection.on "stanza", (stanza) ->

    # Important: never reply to errors!
    if stanza.is("message") and (stanza.attrs.type isnt "error")

      # Swap addresses...
      stanza.attrs.to = stanza.attrs.from
      delete stanza.attrs.from


      # and send back.
      connection.send stanza
    return

  return
errorMixin = (connection) ->
  connection.on "error", (e) ->
    console.error e
    return
  return

xmpp = require("node-xmpp")
argv = process.argv
if (argv.length < 5) and argv
  console.error "Usage: node echo_mixin.js client <my-jid> <my-password>"
  console.error "Or: node echo_mixin.js component <my-jid> <my-password> <host> <port>"
  process.exit 1
cl = null
if argv[2] is "client"
  cl = new xmpp.Client(
    jid: argv[3]
    password: argv[4]
  )
else
  cl = new xmpp.Component(
    jid: argv[3]
    password: argv[4]
    host: argv[5]
    port: argv[6]
  )
cl.on "online", ->
  stanza = new xmpp.Element("presence",
    type: "chat"
  ).c("show").t("chat").up().c("status").t("Happily echoing your <message/> stanzas")
  cl.send stanza
  return

cl.addMixin echoMixin
cl.addMixin errorMixin