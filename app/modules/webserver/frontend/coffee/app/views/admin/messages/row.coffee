class App.Views.Admin.Messages.Row extends System.Views.Base
  template: JST['app/admin/messages/row.html']
  tagName: 'tr'

  initialize: (options) =>
    super
    @listenToOnce @model, "destroy", @onDestroy

  events:
    'click .delete': 'deleteItem'

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
