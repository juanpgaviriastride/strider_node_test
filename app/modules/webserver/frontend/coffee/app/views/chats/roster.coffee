class App.Views.Chats.Roster extends System.Views.Base
  template: JST['app/chats/roster.html']

  initialize: (options) =>
    super

    @listenTo app.me.contacts, 'add', @addOne
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


class App.Views.Chats.RosterItem extends System.Views.Base
  template: JST['app/chats/roster_item.html']
  tagName: 'li'

  initialize: (options) =>
    super


  events:
    'click': 'openChat'

  render: () =>
    super

  getContext: () =>
    {model: @model}

  select: () =>
    @$el.addClass('active')

  unselect: () =>
    @$el.addClass('active')

  openChat: (event) =>
    event.preventDefault()
    @fire('contact:selected', @)
    console.log "Opeingn chat with #{@model.get('local')}"
    Backbone.history.navigate "/messages/@#{@model.get('local')}", {trigger: true}
