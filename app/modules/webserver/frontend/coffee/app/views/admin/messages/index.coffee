class App.Views.Admin.Messages.Index extends Null.Views.Base
  template: JST['app/admin/messages/index.html']

  initialize: (options) =>
    super

    @collection = new App.Collections.Messages()

    @form = new App.Views.Admin.Messages.Form
      collection: @collection

    @table = new App.Views.Admin.Messages.Table
      collection: @collection

  render: () =>
    super

    # @appendView @form.render(), '.create-form'
    @appendView @table.render(), '.list'

    @collection.fetch()
