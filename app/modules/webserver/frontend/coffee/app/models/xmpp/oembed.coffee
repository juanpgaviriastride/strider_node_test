class App.Models.XMPP.Oembed extends System.Models.Base
  urlRoot: '/api/v1/oembed'
  url: () =>
    return "#{@urlRoot}?url=#{@get('link')}"
