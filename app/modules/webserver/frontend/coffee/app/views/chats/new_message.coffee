class App.Views.Chats.NewMessage extends Null.Views.Base
  template: JST['app/chats/new_message.html']

  form: '[data-role="new-message-form"]'

  initialize: (options) =>
    super
    @render()
    @

  events:
    'click [data-role=send-message]': 'saveModel'

  render: () =>
    super

    @contacts = new App.Views.Helpers.Contacts.Select({el: $('select[data-role=to]', @$el)})
    @


  show: () ->
    @contacts.render()
    $('.modal', @$el).modal('show')

  hide: () ->
    $('.modal', @$el).modal('hide')


  saveModel: (e) ->
    e.preventDefault()

    data = @getFormInputs $(@form)

    message =
      "to":  data.to
      "message":  data.message

    console.log "Message to send: ", message

    app.xmpp.sendMessage(data.to, data.message)
