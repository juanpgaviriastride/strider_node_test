class App.Views.TestApi.Devices.Index extends System.Views.Base
  template: JST['app/test_api/devices/index.html']

  initialize: (options) =>
    super

    @collection = new App.Collections.Devices()
    @toke_request_collection = new App.Collections.DevicesRequestToken()

    @form = new App.Views.TestApi.Devices.Form
      collection: @toke_request_collection
      devices: @collection

    @table = new App.Views.TestApi.Devices.Table
      collection: @collection

  render: () =>
    super

    @appendView @form.render(), '.create-form'
    @appendView @table.render(), '.list'

    @collection.fetch()
