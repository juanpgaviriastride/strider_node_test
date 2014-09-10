class App.Routers.TestApi extends System.Routers.Base
  routes:
    '': 'index',
    'patients': 'patients'

  index: =>
    @selectNav('')
    app.current_view = new App.Views.TestApi.Users.Index({el: "#main"})
    app.current_view.render()

  patients: =>
    @selectNav('patients')
    app.current_view = new App.Views.TestApi.Patients.Index({el: "#main"})
    app.current_view.render()
