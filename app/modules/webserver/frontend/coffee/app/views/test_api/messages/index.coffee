class App.Views.TestApi.Messages.Index extends Null.Views.Base
  template: JST['app/test_api/messages/index.html']

  initialize: (options) =>
    super

    @collection = new App.Collections.Messages()

    @form = new App.Views.TestApi.Messages.Form
      collection: @collection

    @table = new App.Views.TestApi.Messages.Table
      collection: @collection

  render: () =>
    super

    # @appendView @form.render(), '.create-form'
    @appendView @table.render(), '.list'

    @collection.fetch()
