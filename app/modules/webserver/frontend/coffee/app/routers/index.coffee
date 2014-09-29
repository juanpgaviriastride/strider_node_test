class App.Routers.Index extends System.Routers.Base
  routes:
    '': 'index',
    'contacts': 'contacts'
    'messages/@:username': 'chat'

  index: =>
    @selectNav('')
    app.loadPage App.Views.Chats.Index, {el: "[data-role=main]"}

  contacts: =>
    @selectNav('contacts')
    app.loadPage App.Views.Contacts.Index, {el: "[data-role=main]"}

  chat: (username) =>
    app.current_chat_with = username[0]
    app.loadPage App.Views.Chats.Chat, {el: "[data-role=main]", username: username[0]}
