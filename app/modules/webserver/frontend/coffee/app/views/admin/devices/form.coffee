class App.Views.Admin.Devices.Form extends Null.Views.Base
  template: JST['app/test_api/devices/form.html']

  form: '.token-reques-form'
  form2: '.device-form'

  initialize: (options) =>
    super
    @devices = options.devices


  events:
    'submit .token-reques-form': 'saveModel'
    'submit .device-form': 'createDevice'

  render: () =>
    super
    @users = new App.Views.Helpers.Users.Select({el: $('select#user', @$el)})

    @

  renderQR: (request_token) =>
    console.log "generating qrcode"

    # @find('.toggle').removeClass('hide')
    @find('.qr-code').html("")
    register_url = "#{request_token.get('host_url')}#{(new App.Collections.Devices()).url}/token/#{request_token.get('request_token')}"
    @find('.qr-code').qrcode(
      ecLevel: 'L'
      size: 400
      text: register_url
    )

    @find('.qr-code-url').val(register_url)

  saveModel: (e) ->
    # @find('.toggle').addClass('hide')
    e.preventDefault()

    data = @getFormInputs $(@form, @$el)

    device_toke_request =
      "user": data.user

    console.log "device token request data: ", device_toke_request
    @token_request = @collection.create device_toke_request, {
      success: (model, response) =>
        console.log "Created", model, response
        @renderQR(model)
      error: (model, response) =>
        console.log "ERror", model, response
      wait: true

    }

  createDevice: (e) =>
    e.preventDefault()

    data = @getFormInputs $(@form2, @$el)

    data =
      "token": data.token

    console.log "device  data: ", data

    device = new App.Models.Device()
    device.urlRoot = "#{device.urlRoot}/token/#{@token_request.get('request_token')}"

    device.save data, {
      success: (model, response) =>
        console.log "Created", model, response
        @devices.add(model, {merge: true})
      error: (model, response) =>
        console.log "ERror", model, response
      wait: true

    }
