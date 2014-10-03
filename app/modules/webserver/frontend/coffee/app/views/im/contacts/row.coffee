class App.Views.IM.Contacts.Row extends Null.Views.Base
  template: JST['app/im/contacts/row.html']
  tagName: 'tr'

  initialize: (options) =>
    super
    @listenToOnce @model, "destroy", @onDestroy

  events:
    'click [data-role=delete]': 'deleteItem'

  render: () =>
    super

  getContext: () =>
    {model: @model}

  deleteItem: (event) =>
    event.preventDefault()
    @fire 'contact:confirm_delete'

  showDeleteModal: () =>
    $('.delete-modal', @$el).modal('show')
    @model.destroy()

  onDestroy: () =>
    @$el.slideUp 'slow', () =>
      @removeAll()
