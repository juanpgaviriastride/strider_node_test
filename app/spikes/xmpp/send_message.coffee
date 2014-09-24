
xmpp = require("node-xmpp-server")
argv = process.argv
if argv.length < 6
  console.error "Usage: node send_message.js <my-jid> <my-password> " + "<server> <port> <my-text> <jid1> [jid2] ... [jidN]"
  process.exit 1

c = new xmpp.Component(
  jid: argv[2]
  password: argv[3]
  host: argv[4]
  port: Number(argv[5])
)

c.addListener "online", ->
  argv.slice(7).forEach (to) ->
    stanza = new xmpp.Element("message",
      to: to
      from: c.jid
      type: "chat"
    ).c("body").t(argv[6])
    c.send stanza
    return


  # nodejs has nothing left to do and will exit
  c.end()
  return

c.addListener "error", (e) ->
  console.error e
  process.exit 1