class App.Routers.Index extends Null.Routers.Base
  routes:
    '': 'index',
    'contacts': 'contacts'
    'messages/@:username': 'chat'

  index: =>
    @selectNav('')
    $a = $("<a>")
    $a.attr('href', "")
    $a.data('role', 'route')
    $a.html("Contacts")
    $('[data-role="breadcrum"]').html($a)
    app.loadPage App.Views.Contacts.Index, {el: "[data-role=main]"}

  contacts: =>
    @selectNav('contacts')

    $a = $("<a>")
    $a.attr('href', "")
    $a.data('role', 'route')
    $a.html("Contacts")
    $('[data-role="breadcrum"]').html($a)

    app.loadPage App.Views.Contacts.Index, {el: "[data-role=main]"}

  chat: (username) =>
    app.current_chat_with = username[0]

    $a = $("<a>")
    $a.attr('href', "")
    $a.data('role', 'route')
    $a.html("@#{app.current_chat_with}")
    $('[data-role="breadcrum"]').html($a)

    app.loadPage App.Views.Chats.Chat, {el: "[data-role=main]", username: username[0]}
