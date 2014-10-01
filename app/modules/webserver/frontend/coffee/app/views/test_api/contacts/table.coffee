class App.Views.TestApi.Contacts.Table extends System.Views.Base
  template: JST['app/test-api/contacts/table.html']

  initialize: (options) =>
    super
    @collection.on "add", @addOne, @

  render: () =>
    super

  addAll: () =>
    @collection.each @addOne

  addOne: (item) =>
    item_view = new App.Views.TestApi.Contacts.Row({model: item})
    @appendView item_view.render(), 'tbody'
