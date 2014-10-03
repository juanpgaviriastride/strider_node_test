class App.Views.Admin.Surgeries.Table extends Null.Views.Base
  template: JST['app/admin/surgeries/table.html']

  initialize: (options) =>
    super

    @collection.on "add", @addOne, @

  render: () =>
    super

  addAll: () =>
    @collection.each @addOne

  addOne: (item) =>
    item_view = new App.Views.Admin.Surgeries.Row({model: item})
    @appendView item_view.render(), 'tbody'
