class App.Routers.IM extends Null.Routers.Base
  routes:
    '': 'index',
    'messages/@:username': 'chat'

  page_class: App.Views.IM.Page

  index: =>
    @selectNav('')
    $a = $("<a>")
    $a.attr('href', "")
    $a.data('role', 'route')
    $a.html("Contacts")
    $('[data-role="breadcrum"]').html($a)
    app.loadPage App.Views.IM.Contacts.Index, {el: "[data-role=main]"}

  chat: (username) =>
    app.current_chat_with = username[0]

    $a = $("<a>")
    $a.attr('href', "")
    $a.data('role', 'route')
    $a.html("@#{app.current_chat_with}")
    $('[data-role="breadcrum"]').html($a)

    app.loadPage App.Views.IM.Chats.Chat, {el: "[data-role=main]", username: username[0]}
