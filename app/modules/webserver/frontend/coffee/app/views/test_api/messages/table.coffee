class App.Views.TestApi.Messages.Table extends System.Views.Base
  template: JST['app/test_api/messages/table.html']

  initialize: (options) =>
    super

    @collection.on "add", @addOne, @

  render: () =>
    super

  addAll: () =>
    @collection.each @addOne

  addOne: (item) =>
    item_view = new App.Views.TestApi.Messages.Row({model: item})
    @appendView item_view.render(), 'tbody'
