class App.Views.Admin.Messages.Table extends Null.Views.Base
  template: JST['app/admin/messages/table.html']

  initialize: (options) =>
    super

    @collection.on "add", @addOne, @

  render: () =>
    super

  addAll: () =>
    @collection.each @addOne

  addOne: (item) =>
    item_view = new App.Views.Admin.Messages.Row({model: item})
    @appendView item_view.render(), 'tbody'
