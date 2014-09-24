class App.Views.TestApi.Contacts.Index extends System.Views.Base
  template: JST['app/test_api/contacts/index.html']

  initialize: (options) =>
    super

    @collection = new App.Collections.Contacts()

    @form = new App.Views.TestApi.Contacts.Form
      collection: @collection

    @table = new App.Views.TestApi.Contacts.Table
      collection: @collection

  render: () =>
    super

    @appendView @form.render(), '.create-form'
    @appendView @table.render(), '.list'

    @collection.fetch()
