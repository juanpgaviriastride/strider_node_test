"use strict"
xmpp = require("node-xmpp-core")
xmpp_client = require("node-xmpp-client")

argv = process.argv

if argv.length < 6
  console.error "Usage: node send_message.js <my-jid> " + "<my-password> <my-text> <jid1> [jid2] ... [jidN]"
  process.exit 1

cl = new xmpp_client(
  jid: argv[2]
  password: argv[3]
)

cl.addListener "online", (data) ->
  console.log "Connected as " + data.jid.user + "@" + data.jid.domain + "/" + data.jid.resource
  argv.slice(5).forEach (to) ->
    stanza = new xmpp.ltx.Element("message",
      to: to
      type: "chat"
    ).c("body").t(argv[4])
    console.log "Sending: ", argv[4]
    cl.send stanza
    return


  # nodejs has nothing left to do and will exit
  cl.end()
  return

cl.addListener "error", (e) ->
  console.error e
  process.exit 1
  return
