class App.Models.XMPP.Message extends Backbone.Model
  parse: (data, opt) =>
    data.from_jid = data.from.bare
    data.to_jid = data.to.bare
    return data
