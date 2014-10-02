class App.Views.TestApi.Surgeries.Row extends Null.Views.Base
  template: JST['app/test_api/surgeries/row.html']
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
