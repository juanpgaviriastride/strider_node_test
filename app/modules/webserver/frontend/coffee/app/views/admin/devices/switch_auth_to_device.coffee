class App.Views.Admin.Devices.SwitchAuthToDevice extends Null.Views.Base
  template: JST['app/admin/devices/switch_auth_to_device.html']

  form: '.switch-auth-form'

  initialize: (options) =>
    super

    @model = new App.Models.User({_id: $.cookies.get('user')._id})
    @model.on "change", @swithSuccess, @


  events:
    'submit .switch-auth-form': 'swithAuthToDevice'
    'click .switch_to_user': 'swithAuthToUser'

  render: () =>
    super

  getContext: () =>
    {model: @model}

  swithAuthToDevice: (event) =>
    event.preventDefault()

    data = @getFormInputs $(@form, @$el)

    $.cookies.set("user_auth_token", $.cookies.get('auth_token'))
    $.cookies.set("auth_token", data.access_token)

    new PNotify
      title: "Authenticated as"
      text: "Using the app as Device"

    @model.fetch()


  swithAuthToUser: (event) =>
    new PNotify
      title: "Authenticated as"
      text: "Using the app as User"

    event.preventDefault()
    $.cookies.set("auth_token", $.cookies.get('user_auth_token'))
    $.cookies.del("user_auth_token")

    @model.fetch()

  swithSuccess: () =>
    alert("Fetch info with the access_token User: #{JSON.stringify(@model.toJSON())}")
