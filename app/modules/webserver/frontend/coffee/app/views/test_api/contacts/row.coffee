class App.Views.TestApi.Contacts.Row extends Null.Views.Base
  template: JST['app/contacts/row.html']
  tagName: 'tr'

  initialize: (options) =>
    super
    @listenToOnce @model, "destroy", @onDestroy

  events:
    'click [data-role=delete]': 'deleteItem'

  render: () =>
    super

  getContext: () =>
    {model: @model}

  deleteItem: (event) =>
    event.preventDefault()
    @model.destroy()

  onDestroy: () =>
    @removeAll()
    alert('item deleted')
