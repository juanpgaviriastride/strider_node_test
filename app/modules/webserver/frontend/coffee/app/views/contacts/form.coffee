class App.Views.Contacts.Form extends System.Views.Base
  template: JST['app/contacts/form.html']

  form: '[data-role=contact-form]'

  initialize: (options) =>
    super

  events:
    'submit [data-role=contact-form]': 'saveModel'

  render: () =>
    super

    @users = new App.Views.Helpers.Users.Select({el: $('select[data-role=contact_id]', @$el)})
    @

  saveModel: (e) ->
    e.preventDefault()

    data = @getFormInputs $(@form)

    contact =
      "contact_id":  data.contact_id

    @collection.create contact, {
      success: (model, response) =>
        console.log "Created", model, response
      error: (model, response) =>
        console.log "ERror", model, response
      wait: true

    }