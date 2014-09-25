xmpp = require("simple-xmpp")
xmpp.on "online", (data) ->
  console.log "Connected with JID: " + data.jid.user
  console.log "Yes, I'm connected!"
  xmpp.send "you@162.209.94.221", "YES"
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
  jid: "me@162.209.94.221"
  password: "123"
  host: "162.209.94.221"
  port: 5222

xmpp.subscribe "you@162.209.94.221"


# check for incoming subscription requests
xmpp.getRoster()