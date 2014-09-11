class App.Views.TestApi.Users.Form extends System.Views.Base
  template: JST['app/test_api/users/form.html']

  form: '.signup-form'

  initialize: (options) =>
    super

  events:
    'submit .signup-form': 'saveModel'

  render: () =>
    super

  saveModel: (e) ->
    e.preventDefault()

    data = @getFormInputs $(@form)

    user =
      "username": data.username,
      "password": data.password,
      "ssn":  data.ssn,
      "name": {
        "prefix": data.prefix_name,
        "first":  data.first_name,
        "last":  data.last_name
      },
      "dob":  data.dob,
      "role":  data.role,
      "contactInfo": {
        "phone":{
          "office":  data.office_phone
          "cell":  data.cellphone
        },
        "email":{
          "personal":  data.personal_email
          "work":  data.work_email
        }
      }

    console.log "User data: ", user
    @collection.create user, {
      success: (model, response) =>
        console.log "Created", model, response
      error: (model, response) =>
        console.log "ERror", model, response
      wait: true

    }
