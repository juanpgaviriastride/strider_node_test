class App.Views.IM.Chats.Index extends Null.Views.Base
  template: JST['app/im/chats/index.html']

  events:
    'click [data-role="new-message"]': 'newMessageModal'

  initialize: (options) =>
    super


  render: () =>
    super

  newMessageModal: (event) =>
    event.preventDefault()

    app.new_message.show()
