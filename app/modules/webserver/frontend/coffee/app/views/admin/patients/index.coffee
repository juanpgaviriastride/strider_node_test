class App.Views.Admin.Patients.Index extends Null.Views.Base
  template: JST['app/admin/patients/index.html']

  initialize: (options) =>
    super

    @collection = new App.Collections.Patients()

    @form = new App.Views.Admin.Patients.Form
      collection: @collection

    @table = new App.Views.Admin.Patients.Table
      collection: @collection

  render: () =>
    super

    @appendView @form.render(), '.create-form'
    @appendView @table.render(), '.list'

    @collection.fetch()
