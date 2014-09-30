class App.Views.TestApi.Devices.Index extends System.Views.Base
  template: JST['app/test_api/devices/index.html']

  initialize: (options) =>
    super

    @collection = new App.Collections.Devices()
    @toke_request_collection = new App.Collections.DevicesRequestToken()

    @form = new App.Views.TestApi.Devices.Form
      collection: @toke_request_collection
      devices: @collection

    @switch_auth = new App.Views.TestApi.Devices.SwitchAuthToDevice()

    @table = new App.Views.TestApi.Devices.Table
      collection: @collection

  events:
    "click .manual-registration": "showManualRegistrationForm"

  render: () =>
    super

    @appendView @form.render(), '.create-form'
    @appendView @switch_auth.render(), '.auth-with-device'
    @appendView @table.render(), '.list'

    @collection.fetch()

  showManualRegistrationForm: (event) =>
    event.preventDefault()
    @find('.auth-with-device').removeClass("hide")
    @find('.device-form').removeClass("hide")
