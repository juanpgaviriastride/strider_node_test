class App.Views.TestApi.Patients.Form extends System.Views.Base
  template: JST['app/test_api/patients/form.html']

  form: '.patient-form'

  initialize: (options) =>
    super

  events:
    'submit .patient-form': 'saveModel'

  render: () =>
    super
    @locations = new App.Views.Helpers.Locations.Select({el: $('select#currentLocation', @$el)})

    @

  saveModel: (e) ->
    e.preventDefault()

    data = @getFormInputs $(@form)

    patient =
      "ssn":  data.ssn,
      "ehr": {
        "ehr": data.ehr,
        "id": data.ehr_id,
      },
      "name": {
        "prefix": data.prefix_name,
        "first":  data.first_name,
        "middle":  data.middle_name,
        "last":  data.last_name
      },
      "contactInfo": {
        "phone":{
          "office":  data.office_phone
          "cell":  data.cellphone
        },
        "email":{
          "personal":  data.personal_email
          "work":  data.work_email
        }
      },
      "allergies": [data.allergies],
      "currentMedications": [data.current_medications],
      "procedures": [data.procedures],
      "currentLocation": data.location


    console.log "Patient data: ", patient
    @collection.create patient, {
      success: (model, response) =>
        console.log "Created", model, response
      error: (model, response) =>
        console.log "ERror", model, response
      wait: true

    }
