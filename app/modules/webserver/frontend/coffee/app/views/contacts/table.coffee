class App.Views.Contacts.Table extends System.Views.Base
  template: JST['app/contacts/table.html']

  initialize: (options) =>
    super

    @collection.on "add", @addOne, @

  render: () =>
    super

  addAll: () =>
    @collection.each @addOne

  addOne: (item) =>
    item_view = new App.Views.Contacts.Row({model: item})
    @appendView item_view.render(), 'tbody'
