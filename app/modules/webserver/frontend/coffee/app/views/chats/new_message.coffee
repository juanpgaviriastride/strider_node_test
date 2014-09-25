class App.Views.Chats.NewMessage extends System.Views.Base
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
    $('.modal', @$el).modal('show')


  hide: () ->
    $('.modal', @$el).modal('hide')


  saveModel: (e) ->
    e.preventDefault()

    data = @getFormInputs $(@form)

    message =
      "to":  data.to
      "message":  data.message

    return console.log "Message to send: ", message
    app.conversations.create message, {
      success: (model, response) =>
        console.log "Created", model, response
      error: (model, response) =>
        console.log "ERror", model, response
      wait: true

    }
