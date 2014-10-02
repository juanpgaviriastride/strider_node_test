class App.Views.Admin.Contacts.Table extends System.Views.Base
  template: JST['app/admin/contacts/table.html']

  initialize: (options) =>
    super
    @collection.on "add", @addOne, @

  render: () =>
    super

  addAll: () =>
    @collection.each @addOne

  addOne: (item) =>
    item_view = new App.Views.Admin.Contacts.Row({model: item})
    @appendView item_view.render(), 'tbody'
