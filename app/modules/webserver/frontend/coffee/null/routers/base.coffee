class Null.Routers.Base extends Backbone.Router
  initialize: (options) =>
    @bind "all", @_change, @

  execute: (cb, args) =>
    app.current_view.remove() if app.current_view?
    cb(args)

  deselectNav: () =>
    $("*[data-href]").removeClass('opened')

  selectNav: (href) =>
    @deselectNav()
    $("*[data-href='#{href}']").addClass('opened')
