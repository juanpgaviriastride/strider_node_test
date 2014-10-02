class App.Views.Admin.Devices.Index extends Null.Views.Base
  template: JST['app/admin/devices/index.html']

  initialize: (options) =>
    super

    @collection = new App.Collections.Devices()
    @toke_request_collection = new App.Collections.DevicesRequestToken()

    @form = new App.Views.Admin.Devices.Form
      collection: @toke_request_collection
      devices: @collection

    @table = new App.Views.Admin.Devices.Table
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
