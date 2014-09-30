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
    'click [data-role="upload-file"]': 'onUploadFile'


  render: () =>
    super

    $('#message', @$el).flextarea({minHeight: 40, maxHeight: 120})
    @

  addAll: =>
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
    return 0

  setSelectionRange: (input, selectionStart, selectionEnd) ->
    if input.setSelectionRange
      input.focus()
      input.setSelectionRange selectionStart, selectionEnd
    else if input.createTextRange
      range = input.createTextRange()
      range.collapse true
      range.moveEnd "character", selectionEnd
      range.moveStart "character", selectionStart
      range.select()
    return

  setCaretToPos: (input, pos) ->
    @setSelectionRange input, pos, pos
    return

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
    console.log "messages: ", data.message
    #data.message = data.message.replace "\n", "</br>"
    return if data.message == "\n"

    body =
      text: data.message

    app.xmpp.sendMessage( app.current_chat_with, body)
    @cleanForm( $(@form) )
    $("#message").val("")
    @setCaretToPos($("#message", @$el), 1)

  onContactSelected: (item) =>
    @__appendedViews.call("unselect")
    item.view.select()


  onUploadFile: (event) =>
    event.preventDefault()
    modal = new App.Views.Chats.UploadFile()
    @appendView modal.render(), "[data-role=modals]"





class App.Views.Chats.Message extends System.Views.Base
  template: JST['app/chats/message.html']
  tagName: 'li'

  initialize: (options) =>
    super
    @

  render: () =>
    super
    if @model.get("body")?.object?
      mime = JSON.parse @model.get("body")?.object
      if mime.content_type?
        content_type = mime.content_type
        if content_type.match "^image/"
          @mime = new App.Views.Chats.MessageImage({model: new Backbone.Model(mime)})

        else if content_type.match "^video/"
          @mime = new App.Views.Chats.MessageVideo({model: new Backbone.Model(mime)})

        @appendView @mime.render(), '[data-role="messange-mime"]'
    @

  getContext: =>
    text = @model.escape("body") if typeof @model.get("body") == "string"
    text = @model.get("body").text if @model.get("body")?.text?

    return {model: @model, text: text}


class App.Views.Chats.UploadFile extends System.Views.Base
  template: JST['app/chats/upload_file.html']

  form: '[data-role="new-message-form"]'

  initialize: (options) =>
    super

    @files = new Backbone.Collection()

    @

  events:
    'click [data-role=upload]': 'saveModel'
    'click [data-role=close]': 'hide'

  render: () =>
    super
    $('.modal', @$el).on 'hidden.bs.modal', @remove
    @show()
    @

  show: () ->
    $('.modal', @$el).modal('show')
    @dropzone = new Dropzone($(".dropzone", @$el).get(0), {
      url: "/api/v1/assets",
      paramName: 'asset',
      addRemoveLinks: false,
      acceptedFiles: "image/*, video/*"
    })
    @dropzone.on "success", @onUploadSuccess
    @dropzone.on "error", @onUploadError

  onUploadSuccess: (file, response) =>
    console.log "UPloaded: ", file, response
    data =
      response : response
      file: file
    @files.add data

  onUploadError: (file, response) =>
    console.log "error: ", response

  hide: () ->
    $('.modal', @$el).modal('hide')

  saveModel: (e) ->
    e.preventDefault()

    @files.each (file) =>
      body =
        "text":  "File #{file.get('file').name}"
        "object": JSON.stringify file.get('response')

      console.log "Message to send: ", body
      app.xmpp.sendMessage( app.current_chat_with, body)

    @hide()


class App.Views.Chats.MessageImage extends System.Views.Base
  template: JST['app/chats/mimes/image.html']

  initialize: (options) =>
    super
    @

  render: () =>
    super
    @

  getContext: =>
    return {src: @model.get('url'), max_width: 800, max_height: 1000}


class App.Views.Chats.MessageVideo extends System.Views.Base
  template: JST['app/chats/mimes/video.html']

  initialize: (options) =>
    super
    @

  render: () =>
    super
    @

  getContext: =>
    return {src: @model.get('url'), content_type: @model.get('content_type'), max_width: 800, max_height: 1000}
