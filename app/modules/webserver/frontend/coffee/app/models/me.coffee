class App.Models.Me extends Backbone.Model
  initialize: (opt) =>
    @jid = "#{opt.username}@#{imConfig.host}"

    # roster item type both
    @contacts = new App.Collections.XMPP.Contacts()

    # not part of roster are the subscirtion sent by other
    @contact_request = new App.Collections.XMPP.ContactRequests()

    # roster item type none
    @request_sent = new App.Collections.XMPP.RequestsSent()


    # roster item type to
    ## TODO

    # roster item type from
    ## TODO


    @messages = new App.Collections.XMPP.Messages()

    @roster_items = new App.Collections.XMPP.RosterItems()


  addContact: (contact) =>
    @contacts.add(contact)

  getContact: (jid) =>
    return @contact.findWhere({ jid: jid})

  addMessage: (msg) =>
    message = new App.Models.XMPP.Message(msg, {parse:true})
    @messages.add(message)

  addContactRequest: (contact_request) =>
    contactRequest = new App.Models.XMPP.ContactRequest(contact_request, {parse:true})
    @contact_request.add contactRequest

  loadRoster: (roster) =>
    @roster_items.add roster.roster.items if roster.roster.items

    @roster_items.each (item) =>
      switch item.get("subscription")
        when "none"
          request_sent = new App.Models.XMPP.RequestSent(item.get('jid'))
          @request_sent.add request_sent
        when "to"
          return
        when "from"
          return
        when "both"
          contact = new App.Models.XMPP.Contact(item.get('jid'))
          @contacts.add contact
        else
          return
