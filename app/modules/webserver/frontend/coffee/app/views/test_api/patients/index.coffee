class App.Views.TestApi.Patients.Index extends Null.Views.Base
  template: JST['app/test_api/patients/index.html']

  initialize: (options) =>
    super

    @collection = new App.Collections.Patients()

    @form = new App.Views.TestApi.Patients.Form
      collection: @collection

    @table = new App.Views.TestApi.Patients.Table
      collection: @collection

  render: () =>
    super

    @appendView @form.render(), '.create-form'
    @appendView @table.render(), '.list'

    @collection.fetch()
