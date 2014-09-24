class App.Views.TestApi.Contacts.Form extends System.Views.Base
  template: JST['app/test_api/contacts/form.html']

  form: '.contact-form'

  initialize: (options) =>
    super

  events:
    'submit .contact-form': 'saveModel'

  render: () =>
    super

    @users = new App.Views.Helpers.Users.Select({el: $('select#contact_id', @$el)})
    @

  saveModel: (e) ->
    e.preventDefault()

    data = @getFormInputs $(@form)

    contact =
      "contact_id":  data.contact_id

    console.log "contaact data: ", contact
    @collection.create contact, {
      success: (model, response) =>
        console.log "Created", model, response
      error: (model, response) =>
        console.log "ERror", model, response
      wait: true

    }
