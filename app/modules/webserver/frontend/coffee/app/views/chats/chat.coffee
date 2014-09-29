class App.Views.Chats.Chat extends System.Views.Base
  template: JST['app/chats/chat.html']

  form: '[data-role="new-message-form"]'

  initialize: (options) =>
    super

    @fetched = false
    @old_messages = new App.Collections.XMPP.Messages()

    @listenTo app.me.messages, 'add', (item)=>
      if item.get('from')?.split('@')[0] == app.current_chat_with or (item.get('from') == app.me.jid and item.get('to').split('@')[0] == app.current_chat_with)
        @old_messages.add(item)
        @addOne(item, false) if @fetched


    @old_messages.fetch({
      data:
        to: app.me.get("username")
        from: app.current_chat_with
        conversation: true

      success: (collection, response) =>
        @addAll()
      error: (collection, response) =>
        @addAll()
    })
    @on "contact:selected", @onContactSelected

    @render()
    @

  events:
    'keyup #message': 'onKeyPress'


  render: () =>
    super

    $('#message', @$el).flextarea({minRows: 2, maxRows: 8})
    @

  addAll: =>
    # @old_messages.add(app.me.messages.filter((item) =>
    #   return item.get('from')?.split('@')[0] == app.current_chat_with or (item.get('from') == app.me.jid and item.get('to')?.split('@')[0] == app.current_chat_with)
    # ))
    # @old_messages.sort()
    @fetched = true
    @old_messages.each (msg) =>
      @addOne(msg, true)

    $('body').scrollTop($('body').prop("scrollHeight"))

  addOne: (item, all = false) =>
    if item.get('from')?.split('@')[0] == app.current_chat_with or (item.get('from') == app.me.jid and item.get('to').split('@')[0] == app.current_chat_with)
      item_view = new App.Views.Chats.Message({model: item})
      @appendView item_view.render(), '[data-role=messages-list]'

      # scroll on message but no when loading history
      unless all
        $('body').animate({ scrollTop: $('body')[0].scrollHeight}, 1000)

  getCaret: () =>
    el = $('#message', @$el)
    if el.selectionStart
      return el.selectionStart
    else if document.selection
      el.focus()
      r = document.selection.createRange()
      return 0  unless r?
      re = el.createTextRange()
      rc = re.duplicate()
      re.moveToBookmark r.getBookmark()
      rc.setEndPoint "EndToStart", re
      return rc.text.length
  0

  onKeyPress: (event) =>
    $el = $('#message', @$el)
    if event.keyCode is 13 and event.shiftKey
      content = $el.val()
      caret = @getCaret()
      @value = content.substring(0, caret) + "\n" + content.substring(caret, content.length)
      event.stopPropagation()
    else if event.keyCode is 13 and not event.shiftKey
      @sendMessage()
      event.preventDefault()

  sendMessage: (e) =>
    data = @getFormInputs( $(@form))
    console.log "data: ", data
    #form = _.clone( data)

    app.xmpp.sendMessage( app.current_chat_with, data.message)
    @cleanForm( $(@form) )

  onContactSelected: (item) =>
    @__appendedViews.call("unselect")
    item.view.select()




class App.Views.Chats.Message extends System.Views.Base
  template: JST['app/chats/message.html']
  tagName: 'li'

  initialize: (options) =>
    super
    @

  render: () =>
    super
    @

  getContext: =>
    return {model: @model}
