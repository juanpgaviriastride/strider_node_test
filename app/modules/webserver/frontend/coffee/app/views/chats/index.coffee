class App.Views.Chats.Index extends System.Views.Base
  template: JST['app/chats/index.html']

  events:
    'click [data-role="new-message"]': 'newMessageModal'

  initialize: (options) =>
    super


  render: () =>
    super

  newMessageModal: (event) =>
    event.preventDefault()

    app.new_message.show()
