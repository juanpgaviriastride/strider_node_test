class App.Views.Admin.Users.Index extends Null.Views.Base
  template: JST['app/admin/users/index.html']

  initialize: (options) =>
    super

    @collection = new App.Collections.Users()

    @form = new App.Views.Admin.Users.Form
      collection: @collection

    @table = new App.Views.Admin.Users.Table
      collection: @collection

  render: () =>
    super

    @appendView @form.render(), '.create-form'
    @appendView @table.render(), '.list'

    @collection.fetch()
