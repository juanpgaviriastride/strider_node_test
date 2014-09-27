class App.Routers.Index extends System.Routers.Base
  routes:
    '': 'index',
    'contacts': 'contacts'
    'messages/@:username': 'chat'


  index: =>
    @selectNav('')
    app.current_view = new App.Views.Chats.Index({el: "[data-role=main]"})
    app.current_view.render()

    # app.chats_open = new App.Views.Chats.List({el: "[data-role=chats]"})
    # app.chats_open.render()

  contacts: =>
    @selectNav('contacts')
    app.current_view = new App.Views.Contacts.Index({el: "[data-role=main]"})
    app.current_view.render()

    # app.chats_open = new App.Views.Chats.List({el: "[data-role=chats]"})
    # app.chats_open.render()


  chat: (username) =>
    app.current_chat_with = username[0]
    app.current_view = new App.Views.Chats.Chat({el: "[data-role=main]", username: username[0]})
    app.current_view.render()
