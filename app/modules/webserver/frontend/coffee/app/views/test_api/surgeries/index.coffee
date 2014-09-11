class App.Views.TestApi.Surgeries.Index extends System.Views.Base
  template: JST['app/test_api/surgeries/index.html']

  initialize: (options) =>
    super

    @collection = new App.Collections.Surgeries()

    @form = new App.Views.TestApi.Surgeries.Form
      collection: @collection

    @table = new App.Views.TestApi.Surgeries.Table
      collection: @collection

  render: () =>
    super

    @appendView @form.render(), '.create-form'
    @appendView @table.render(), '.list'

    @collection.fetch()
