class App.Views.Contacts.Table extends System.Views.Base
  template: JST['app/contacts/table.html']

  initialize: (options) =>
    super

    @collection.on "add", @addOne, @

  render: () =>
    @on 'contact:confirm_delete', @onConfirmDelete
    super

  addAll: () =>
    @collection.each @addOne

  addOne: (item) =>
    item_view = new App.Views.Contacts.Row({model: item})
    @appendView item_view.render(), 'tbody'

  onConfirmDelete: (event) =>
    modal = new App.Views.Common.DeleteConfirmation(model: event.view.model)
    @appendView modal.render(), "[data-role=modals]"

    return
