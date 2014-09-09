class App.Views.TestApi.Users.Form extends System.Views.Base
  template: JST['app/test_api/users/form.html']

  form: '.signup-form'

  initialize: (options) =>
    super

  events:
    'submit .signup-form': 'saveModel'

  render: () =>
    super

  saveModel: (e) ->
    e.preventDefault()

    data = @getFormInputs $(@form)

    console.log "User data: ", data
    @collection.create data, {
      success: (model, response) =>
        console.log "Created", model, response
      error: (model, response) =>
        console.log "ERror", model, response
      wait: true

    }
