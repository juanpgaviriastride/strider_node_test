class App.Views.Me.Info extends System.Views.Base
  template: JST['app/me/info.html']

  initialize: (options) =>
    super

    @listenTo @model, "change", @render
    @render()
    @

  render: () =>
    super

  getContext: =>
    return {model: @model}
