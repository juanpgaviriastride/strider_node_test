class App.Views.Admin.Messages.Form extends Null.Views.Base
  template: JST['app/admin/messages/form.html']

  form: '.message-form'

  initialize: (options) =>
    super

  events:
    'submit .message-form': 'saveModel'

  render: () =>
    super

  saveModel: (e) ->
    e.preventDefault()

    data = @getFormInputs $(@form)

    message =
      "text":  data.text,


    console.log "message data: ", message
    @collection.create message, {
      success: (model, response) =>
        console.log "Created", model, response
      error: (model, response) =>
        console.log "ERror", model, response
      wait: true

    }
