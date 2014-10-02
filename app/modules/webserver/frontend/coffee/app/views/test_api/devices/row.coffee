class App.Views.TestApi.Devices.Row extends Null.Views.Base
  template: JST['app/test_api/devices/row.html']
  tagName: 'tr'

  initialize: (options) =>
    super
    @listenToOnce @model, "destroy", @onDestroy
    @listenTo @model, "change", @render

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
