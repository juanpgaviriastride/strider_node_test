class App.Models.Me extends Backbone.Model
  initialize: (opt) =>
    @jid = "#{opt.username}@#{imConfig.host}"

    # roster item type both
    @contacts = new App.Collections.XMPP.Contacts()

    # not part of roster are the subscirtion sent by other
    @contact_request = new App.Collections.XMPP.ContactRequests()

    # roster item type none
    @request_sent = new App.Collections.XMPP.RequestsSent()


    @messages = new App.Collections.XMPP.Messages()

    @roster_items = new App.Collections.XMPP.RosterItems()


  addContact: (contact) =>
    contact = new App.Models.XMPP.Contact(contact, {parse: true})
    @contacts.add contact, {merge: true}

  addRequestSent: (contact) =>
    request_sent = new App.Collections.XMPP.RequestsSent(contact)
    @request_sent.add request_sent

  getContact: (jid) =>
    return @contact.findWhere({ jid: jid})

  addMessage: (msg) =>
    msg.timestamp = moment().toISOString()
    message = new App.Models.XMPP.Message(msg, {parse:true})
    @messages.add(message)

  checkContactRequestSent: (username) =>
    already_sent = @roster_items.find( (item) =>
      return item.get('subscription') == "to" and item.get('jid').local == username
    )
    return already_sent if already_sent?
    return false

  addContactRequest: (contact_request) =>
    contactRequest = new App.Models.XMPP.ContactRequest(contact_request, {parse:true})
    @contact_request.add contactRequest

  loadRoster: (roster) =>
    @roster_items.add roster.roster.items if roster.roster.items

    @roster_items.each (item) =>
      switch item.get("subscription")
        when "none"
          @addRequestSent item.get('jid')
          return
        when "to"
          @addRequestSent item.get('jid')
          return
        when "from"
          data = item.get('jid')
          data.subscription = "from"
          @addContact data
          return
        when "both"
          data = item.get('jid')
          data.subscription = "both"
          @addContact data
          return
        else
          return
