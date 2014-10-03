class App.Views.IM.Contacts.Form extends Null.Views.Base
  template: JST['app/im/contacts/form.html']

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

    app.xmpp.sendSubscription($('select[data-role=contact_id] option:selected', @$el).data('username'))
