class App.Views.Admin.Locations.Index extends Null.Views.Base
  template: JST['app/admin/locations/index.html']

  initialize: (options) =>
    super

    @collection = new App.Collections.Locations()

    @form = new App.Views.Admin.Locations.Form
      collection: @collection

    @table = new App.Views.Admin.Locations.Table
      collection: @collection

  render: () =>
    super

    @appendView @form.render(), '.create-form'
    @appendView @table.render(), '.list'

    @collection.fetch()
