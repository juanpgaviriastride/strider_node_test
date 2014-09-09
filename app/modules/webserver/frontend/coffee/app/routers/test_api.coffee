class App.Routers.TestApi extends System.Routers.Base
  routes:
    '': 'index',
    'people': 'people'

  index: =>
    @selectNav('')
    app.current_view = new App.Views.TestApi.Users.Index({el: "#main"})
    app.current_view.render()

  people: =>
    console.log "people"
