class App.Views.Admin.Surgeries.Index extends System.Views.Base
  template: JST['app/admin/surgeries/index.html']

  initialize: (options) =>
    super

    @collection = new App.Collections.Surgeries()

    @form = new App.Views.Admin.Surgeries.Form
      collection: @collection

    @table = new App.Views.Admin.Surgeries.Table
      collection: @collection

  render: () =>
    super

    @appendView @form.render(), '.create-form'
    @appendView @table.render(), '.list'

    @collection.fetch()
