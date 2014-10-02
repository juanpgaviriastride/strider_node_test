class App.Views.TestApi.Surgeries.Table extends Null.Views.Base
  template: JST['app/test_api/surgeries/table.html']

  initialize: (options) =>
    super

    @collection.on "add", @addOne, @

  render: () =>
    super

  addAll: () =>
    @collection.each @addOne

  addOne: (item) =>
    item_view = new App.Views.TestApi.Surgeries.Row({model: item})
    @appendView item_view.render(), 'tbody'
