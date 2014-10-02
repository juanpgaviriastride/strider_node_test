class App.Views.Admin.Patients.Table extends System.Views.Base
  template: JST['app/admin/patients/table.html']

  initialize: (options) =>
    super

    @collection.on "add", @addOne, @

  render: () =>
    super

  addAll: () =>
    @collection.each @addOne

  addOne: (item) =>
    item_view = new App.Views.Admin.Patients.Row({model: item})
    @appendView item_view.render(), 'tbody'
