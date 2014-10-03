class App.Views.TestApi.Locations.Table extends Null.Views.Base
  template: JST['app/test_api/locations/table.html']

  initialize: (options) =>
    super

    @collection.on "add", @addOne, @

  render: () =>
    super

  addAll: () =>
    @collection.each @addOne

  addOne: (item) =>
    item_view = new App.Views.TestApi.Locations.Row({model: item})
    @appendView item_view.render(), 'tbody'
