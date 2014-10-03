class App.Views.IM.Contacts.Index extends Null.Views.Base
  template: JST['app/im/contacts/index.html']

  initialize: (options) =>
    super

    @collection = new App.Collections.Contacts()

    @form = new App.Views.IM.Contacts.Form
      collection: @collection

    @table = new App.Views.IM.Contacts.Table
      collection: @collection

  render: () =>
    super

    @appendView @form.render(), '[data-role=create-form]'
    @appendView @table.render(), '[data-role=list]'

    @collection.fetch()
