xmpp = require("simple-xmpp")
xmpp.on "online", (data) ->
  console.log "Connected with JID: " + data.jid.user
  console.log "Yes, I'm connected!"
  xmpp.send "your.friend@gmail.com", "HEEEEEEEY"
  return

xmpp.on "chat", (from, message) ->
  xmpp.send from, "echo: " + message
  return

xmpp.on "error", (err) ->
  console.error err
  return

xmpp.on "subscribe", (from) ->
  xmpp.acceptSubscription from  if from is "a.friend@gmail.com"
  return

xmpp.connect
  jid: "username@gmail.com"
  password: "password"
  host: "localhost"
  port: 5222

xmpp.subscribe "your.friend@gmail.com"


# check for incoming subscription requests
xmpp.getRoster()