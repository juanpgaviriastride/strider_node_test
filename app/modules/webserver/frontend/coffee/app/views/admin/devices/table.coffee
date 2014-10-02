class App.Views.Admin.Devices.Table extends System.Views.Base
  template: JST['app/admin/devices/table.html']

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
    item_view = new App.Views.Admin.Devices.Row({model: item})
    @appendView item_view.render(), 'tbody'

  refresh: () =>
    @collection.fetch()
