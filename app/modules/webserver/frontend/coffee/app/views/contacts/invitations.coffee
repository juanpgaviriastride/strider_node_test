class App.Views.Contacts.Invitations extends System.Views.Base
  template: JST['app/contacts/invitations.html']

  initialize: (options) =>
    super

    @listenTo app.me.contact_request, "add", @addOne, @
    @listenTo app.me.contact_request, "remove", @removeOne, @
    @render()
    @

  render: () =>
    super

  addAll: () =>
    app.me.contact_request @addOne

  addOne: (item) =>
    $unread = $('[data-role="pending-invitations-count"]')
    unread_messages = (if $unread.html() == "" then 0 else parseInt($unread.html()))
    $unread.html unread_messages + 1

    @find('[data-role="invitation-list-none"]').hide()
    item_view = new App.Views.Contacts.Invitation({model: item})
    @appendAfterView item_view.render(), '[data-role="invitation-list"]'

  removeOne: (item) =>
    $unread = $('[data-role="pending-invitations-count"]')

    if app.me.contact_request.length == 0
      @find('[data-role="invitation-list-none"]').show()
      $unread.html ''
    else
      unread_messages = (if parseInt($unread.html()) == 1 then '' else parseInt($unread.html()) )
      if unread_messages == ''
        $unread.html ''
      else
        $unread.html unread_messages - 1



class App.Views.Contacts.Invitation extends System.Views.Base
  template: JST['app/contacts/invitation.html']
  tagName: 'li'
  className: "contact"

  events:
    "click a[data-role=contact-info]": "onClick"
    "click a[data-role=accept]": "onAccept"
    "click a[data-role=reject]": "onReject"

  initialize: (options) =>
    super
    @listenToOnce @model, "destroy", @removeAll(), @

  render: () =>
    super

  getContext: =>
    return { model: @model }

  onClick: (event) =>
    event.preventDefault()
    event.stopPropagation()

  onAccept: (event) =>
    event.preventDefault()
    event.stopPropagation()

    app.xmpp.acceptSubscription(@model.get('from').local, @model.get('from'), 'from')
    @$el.slideUp( () =>
      app.me.contact_request.remove @model
    )

  onReject: (event) =>
    event.preventDefault()
    event.stopPropagation()

    app.xmpp.rejectSubscription(@model.get('from').local)
    @$el.slideUp( () =>
      app.me.contact_request.remove @model
    )
