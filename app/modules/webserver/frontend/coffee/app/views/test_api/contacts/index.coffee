class App.Views.TestApi.Contacts.Index extends Null.Views.Base
  template: JST['app/test_api/contacts/index.html']

  initialize: (options) =>
    super

    @collection = new App.Collections.Contacts()

    @form = new App.Views.Contacts.Form
      collection: @collection

    @table = new App.Views.Contacts.Table
      collection: @collection

  render: () =>
    super

    @appendView @form.render(), '.create-form'
    @appendView @table.render(), '.list'

    @collection.fetch()
