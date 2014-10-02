class App.Views.Admin.Contacts.Index extends System.Views.Base
  template: JST['app/admin/contacts/index.html']

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
