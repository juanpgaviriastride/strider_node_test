class App.Views.TestApi.Devices.Table extends Null.Views.Base
  template: JST['app/test_api/devices/table.html']

  initialize: (options) =>
    super

    @collection.on "add", @addOne, @

  events:
    'click .refresh': "refresh"

  render: () =>
    super

  addAll: () =>
    @collection.each @addOne

  addOne: (item) =>
    item_view = new App.Views.TestApi.Devices.Row({model: item})
    @appendView item_view.render(), 'tbody'

  refresh: () =>
    @collection.fetch()
