class App.Views.TestApi.Patients.Table extends Null.Views.Base
  template: JST['app/test_api/patients/table.html']

  initialize: (options) =>
    super

    @collection.on "add", @addOne, @

  render: () =>
    super

  addAll: () =>
    @collection.each @addOne

  addOne: (item) =>
    item_view = new App.Views.TestApi.Patients.Row({model: item})
    @appendView item_view.render(), 'tbody'
