class App.Views.Admin.Locations.Form extends System.Views.Base
  template: JST['app/admin/locations/form.html']

  form: '.location-form'

  initialize: (options) =>
    super

  events:
    'submit .location-form': 'saveModel'

  render: () =>
    super

  saveModel: (e) ->
    e.preventDefault()

    data = @getFormInputs $(@form)

    location =
      "display_name":  data.display_name,
      "geo": {
        "text": data.display_name,
        "coordinates":  [data.lng, data.lat]
        "type": 'Point'
      }

    console.log "message data: ", location
    @collection.create location, {
      success: (model, response) =>
        console.log "Created", model, response
      error: (model, response) =>
        console.log "ERror", model, response
      wait: true

    }
