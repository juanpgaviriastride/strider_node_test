class App.Views.Admin.Devices.Row extends System.Views.Base
  template: JST['app/admin/devices/row.html']
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
