class App.Views.Admin.Surgeries.Form extends Null.Views.Base
  template: JST['app/admin/surgeries/form.html']

  form: '.surgery-form'

  initialize: (options) =>
    super

  events:
    'submit .surgery-form': 'saveModel'

  render: () =>
    super
    @patients = new App.Views.Helpers.Patients.Select({el: $('select#patient', @$el)})
    @locations = new App.Views.Helpers.Locations.Select({el: $('select#location', @$el)})

    @

  saveModel: (e) ->
    e.preventDefault()

    data = @getFormInputs $(@form)

    surgery =
      "ssn":  data.ssn,
      "display_name": data.display_name
      "time":{
        "start": moment("#{data.start_date} #{data.start_time}").toISOString()
        "end": moment("#{data.end_date} #{data.end_time}").toISOString()
      },
      "patientId": data.patient
      "location": data.location,
      "status": data.status,

    console.log "Surgery data: ", surgery
    @collection.create surgery, {
      success: (model, response) =>
        console.log "Created", model, response
      error: (model, response) =>
        console.log "ERror", model, response
      wait: true

    }
