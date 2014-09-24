#
# Component = require("node-xmpp-component")
# ltx = require("node-xmpp-core").ltx
#
# argv = process.argv
#
# component = new Component(
#   jid: "192.168.50.1"
#   password: "123"
#   host: "192.168.50.4"
#   port: "5347"
# )
# component.on "online", ->
#   console.log "Component is online"
#   iq = new ltx.Element("iq",
#     type: "set"
#     id: "reg2"
#     to: "192.168.50.4"
#   ).c("query",
#     xmlns: "jabber:iq:register"
#   )
#
#   iq = new ltx.Element("iq",
#     type: "set"
#     id: "req2"
#   ).c("query",
#     xmlns: 'jabber:iq:register'
#   ).c("username").t(argv[4]).up().c("password").t(argv[5])#.up().c('email').t(argv[4])
#
#   component.send iq
#   return
#
# component.on "error", (e) ->
#   console.error e
#   process.exit 1
#   return



"use strict"
xmpp = require("node-xmpp-core")
xmpp_client = require("node-xmpp-client")

argv = process.argv

if argv.length < 6
  console.error "Usage: node send_message.js <my-jid> " + "<my-password> <new-username> <new-user-pw>"
  process.exit 1

cl = new xmpp_client(
  jid: argv[2]
  password: argv[3]
)

cl.addListener "online", (data) ->
  console.log "Connected as " + data.jid.user + "@" + data.jid.domain + "/" + data.jid.resource
  argv.slice(5).forEach (to) ->
    """
    <iq type='get' id='reg1' to='shakespeare.lit'>
  <query xmlns='jabber:iq:register'/>
</iq>
    """

    stanza = new xmpp.ltx.Element("iq",
      type: "get"
      #to: '192.168.50.4'
      id: "req1"
    ).c("query",
      xmlns: 'jabber:iq:register'
    )
    console.log "Sending: ", argv[4]
    #cl.send stanza

    msg = "<iq type='set' id='reg2'><query xmlns='jabber:iq:register'><username>" + argv[4] + "</username><password>" + argv[5] + "</password></query></iq>"
    cl.send stanza
    return


  # nodejs has nothing left to do and will exit
  #cl.end()
  return

cl.addListener "stanza", (stanza) ->
  console.log "STANZA: ", stanza

  if stanza.attrs.type is "error"
    console.log "ERROR: ", stanza.root().toString()
    return

  if stanza.is('iq') and stanza.attrs.type isnt "error"
    console.log "IN BAND RESPONSE: ", stanza.getChild('query')
    # register a new user
    """
    <iq type='set' id='reg2'>
  <query xmlns='jabber:iq:register'>
    <username>bill</username>
    <password>Calliope</password>
    <email>bard@shakespeare.lit</email>
  </query>
</iq>

<stream:stream xmlns:stream='http://etherx.jabber.org/streams' xmlns='jabber:component:accept' to='192.168.50.1'><iq type="set"><query xmlns="jabber:iq:register"><username>pepe@192.168.50.4</username><password>123</password></query></iq>
</stream>
    """

    in_band_request_stanza = new xmpp.ltx.Element("iq",
      type: "set"
      id: "req2"
    ).c("query",
      xmlns: 'jabber:iq:register'
    ).c("username").t(argv[4]).up().c("password").t(argv[5])#.up().c('email').t(argv[4])

    console.log "IN_BAND REQUEST: ", in_band_request_stanza.root().toString()

    cl.send in_band_request_stanza
    return

    #msg = "<stream xmlns='http://etherx.jabber.org/streams' xmlns='jabber:component:accept' to='192.168.50.4'><iq type='set'><query xmlns='jabber:iq:register'><username>#{argv[4]}</username><password>#{argv[5]}</password></query></iq></stream>"
    msg = "<iq type='set' id='reg2'><query xmlns='jabber:iq:register'><username>" + argv[4] + "</username><password>" + argv[5] + "</password></query></iq>"
    console.log "IN_BAND REQUEST: ", msg
    cl.send msg
    return

  # Important: never reply to errors!

  if stanza.is("message") and (stanza.attrs.type isnt "error")

    # Swap addresses...
    stanza.attrs.to = stanza.attrs.from
    delete stanza.attrs.from


    # and send back
    console.log "Message From: #{stanza.attrs.to}, message: ", stanza.getChild('body').getText()
    #client.send stanza
  return


cl.addListener "error", (e) ->
  console.error e
  process.exit 1
  return
