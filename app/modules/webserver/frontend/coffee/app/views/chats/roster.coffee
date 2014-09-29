class App.Views.Chats.Roster extends System.Views.Base
  template: JST['app/chats/roster.html']

  initialize: (options) =>
    super

    @listenTo app.me.contacts, 'add', @addOne
    @listenTo app.me.messages, 'add', @newMessage

    @render()

    @on "contact:selected", @onContactSelected

    @

  render: () =>
    super

  addOne: (item) =>
    item_view = new App.Views.Chats.RosterItem({model: item})
    @appendView item_view.render(), '[data-role=roster-list]'

  onContactSelected: (item) =>
    @__appendedViews.call("unselect")
    item.view.select()

  newMessage: (item) =>
    if item.get('from')?.split('@')[0] == app.current_chat_with or item.get('from') == app.me.jid
      return
    else
      contact = app.me.contacts.findWhere {id: item.get('from') }
      roster_item = @__appendedViews.findByModel contact
      roster_item.addMessage(item)



class App.Views.Chats.RosterItem extends System.Views.Base
  template: JST['app/chats/roster_item.html']
  tagName: 'li'

  initialize: (options) =>
    super
    @listenTo @model, "change", @render


  events:
    'click': 'openChat'

  render: () =>
    super

  getContext: () =>
    {model: @model}

  select: () =>
    @$el.addClass('active')

  unselect: () =>
    @$el.removeClass('active')

  addMessage: (item) =>
    $unread = $('[data-role="unread-messages"]', @$el)

    unread_messages = parseInt $unread.html()
    $unread.html unread_messages + 1

    $unread.show()

  openChat: (event) =>
    event.preventDefault()
    $unread = $('[data-role="unread-messages"]', @$el)
    $unread.hide()
    $unread.html('0')

    @fire('contact:selected', @)
    Backbone.history.navigate "/messages/@#{@model.get('local')}", {trigger: true}