xmpp = require("simple-xmpp")
xmpp.on "online", (data) ->
  console.log "Connected with JID: " + data.jid.user
  console.log "Yes, I'm connected!"
  xmpp.send "admin@192.168.50.4", "YES"
  return

xmpp.on "chat", (from, message) ->
  console.log "MSG: ", message
  xmpp.send from, "echo: " + message
  return

xmpp.on "error", (err) ->
  console.error err
  return

xmpp.on "subscribe", (from) ->
  console.log "subscribe"
  xmpp.acceptSubscription from  #if from is "user2@54.187.172.45"
  return

xmpp.connect
  jid: "me@192.168.50.4"
  password: "123"
  host: "192.168.50.4"
  port: 5222

xmpp.subscribe "admin@192.168.50.4"


# check for incoming subscription requests
xmpp.getRoster()