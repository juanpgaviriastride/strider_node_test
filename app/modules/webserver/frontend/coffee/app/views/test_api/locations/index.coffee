class App.Views.TestApi.Locations.Index extends System.Views.Base
  template: JST['app/test_api/locations/index.html']

  initialize: (options) =>
    super

    @collection = new App.Collections.Locations()

    @form = new App.Views.TestApi.Locations.Form
      collection: @collection

    @table = new App.Views.TestApi.Locations.Table
      collection: @collection

  render: () =>
    super

    @appendView @form.render(), '.create-form'
    @appendView @table.render(), '.list'

    @collection.fetch()
