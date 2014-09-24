xmpp = require("node-xmpp")

if process.argv.length < 6
  console.error "Usage: node send_message.js <my-jid> <my-password> <my-text> <jid1> [jid2] ... [jidN]"
  process.exit 1

cl = new xmpp.Client(
  jid: process.argv[2]
  password: process.argv[3]
)

cl.addListener "online", ->


  console.log('online')
  cl.send(new xmpp.Element('presence', { })
    .c('show').t('chat').up()
    .c('status').t('Happily echoing your <message/> stanzas')
  )

  process.argv.slice(5).forEach (to) ->
    cl.send new xmpp.Element("message",
      to: to
      type: "chat"
    ).c("body").t(process.argv[4])
    cl.end()

cl.addListener "stanza", (stanza) ->

  if stanza.is("message") and stanza.attrs.type isnt "error"
    console.log "New message"

    # Swap addresses...
    stanza.attrs.to = stanza.attrs.from
    delete stanza.attrs.from

    # and send back.
    cl.send stanza


cl.addListener "error", (e) ->
  console.error e
  process.exit 1
