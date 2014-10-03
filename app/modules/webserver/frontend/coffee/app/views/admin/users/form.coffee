class App.Views.Admin.Users.Form extends Null.Views.Base
  template: JST['app/admin/users/form.html']

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
      "prefix_name": data.prefix_name,
      "first_name":  data.first_name,
      "last_name":  data.last_name,
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

# $(document).ready ->
#   $('#wizard1').bootstrapWizard ->
#     'nextSelector': '.button-next'
#     'previousSelector': '.button-previous'

#     onNext: (tab, navigation, index) ->

#     hasError = (id) ->
#       $(id).parent().parent().addClass('has-error')
#       bugs = 1

#       if index is 1
#         bugs = 0

#         hasError('#email-w1') unless isEmail($('#email-w1').val())

#         hasError('#password-w1') unless $('#password-w1').val()

#         false if bugs == 1

#       if index is 2
#         bugs = 0

#         hasError('#name-w1') unless $('#name-w1').val()
#         hasError('#ccnumber-w1') unless $('#ccnumber-w1').val()
#         hasError('#cvv-w1') unless $('#cvv-w1').val()

#         if bugs is 2
#           return false

#     onTabShow: (tab, navigation, index) ->
#       $total = navigation.find('li').length
#       $current = index+1
#       $percent = ($current/$total) * 100

#       showFinishBtn = ->
#         $('#wizard1').find('.button-next').hide()
#         $('#wizard1').find('.button-finish').show()

#       hideFinishBtn = ->
#         $('#wizard1').find('.button-next').show()
#         $('#wizard1').find('.button-finish').hide()

#       $('#wizard1').find('.progress-bar').css ->
#         width:$percent+'%'

#       $('#wizard1 > .steps li').each = (index) ->
#         $(this).removeClass('complete')
#         index += 1
#         $(this).addClass('complete') if index < $current

#       if $current >= $total then showFinishBtn else hideFinishBtn
