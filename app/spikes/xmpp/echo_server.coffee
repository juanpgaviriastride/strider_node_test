xmpp = require "node-xmpp"

r = new xmpp.Router()
r.register "gmail.com", (stanza) ->
  console.log "<< " + stanza.toString()
  if stanza.attrs.type isnt "error"
    me = stanza.attrs.to
    stanza.attrs.to = stanza.attrs.from
    stanza.attrs.from = me
    r.send stanza
  return