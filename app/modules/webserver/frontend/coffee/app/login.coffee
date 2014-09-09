$(document).ready () ->
  $('.form-signin').submit (e) ->
    e.preventDefault()

    data =
      username: $('#username').val(),
      password: $('#password').val()

    $.ajax({
      url: '/api/v1/auth/local'
      type: 'post'
      data: data
      dataType: 'json'

      success: (data) ->
        $.cookies.set('auth_token', data.token)
        $.cookies.set('user', data)
        window.location.reload()
      error: (xhr, error) ->
        alert "Bad username or password"

    })
    return false
