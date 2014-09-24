"use strict"

###*
Echo Bot - the XMPP Hello World
###
Client = require("node-xmpp-client")
argv = process.argv
ltx = require("ltx")

if 4 isnt argv.length
  console.error "Usage: node echo_bot.js <my-jid> <my-password>"
  process.exit 1
client = new Client(
  jid: argv[2]
  password: argv[3]
)

client.on "online", ->
  console.log "online"
  #client.send new ltx.Element("presence", {}).c("show").t("chat").up().c("status").t("Happily echoing your <message/> stanzas")
  return


client.on "stanza", (stanza) ->

  # Important: never reply to errors!
  if stanza.is("message") and (stanza.attrs.type isnt "error")

    # Swap addresses...
    stanza.attrs.to = stanza.attrs.from
    delete stanza.attrs.from


    # and send back
    console.log "Message From: #{stanza.attrs.to}, message: ", stanza.getChild('body').getText()
    #client.send stanza
  return

client.on "error", (e) ->
  console.error e
  return
