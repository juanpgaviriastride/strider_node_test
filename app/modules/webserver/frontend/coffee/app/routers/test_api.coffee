class App.Routers.TestApi extends System.Routers.Base
  routes:
    '': 'index',
    'patients': 'patients'
    'surgeries': 'surgeries'
    'locations': 'locations'
    'messages': 'messages'
    'devices': 'devices'
    'contacts': 'contacts'

  index: =>
    @selectNav('')
    app.current_view = new App.Views.TestApi.Users.Index({el: "#main"})
    app.current_view.render()

  patients: =>
    @selectNav('patients')
    app.current_view = new App.Views.TestApi.Patients.Index({el: "#main"})
    app.current_view.render()

  surgeries: =>
    @selectNav('surgeries')
    app.current_view = new App.Views.TestApi.Surgeries.Index({el: "#main"})
    app.current_view.render()

  locations: =>
    @selectNav('locations')
    app.current_view = new App.Views.TestApi.Locations.Index({el: "#main"})
    app.current_view.render()

  messages: =>
    @selectNav('messages')
    app.current_view = new App.Views.TestApi.Messages.Index({el: "#main"})
    app.current_view.render()

  devices: =>
    @selectNav('devices')
    app.current_view = new App.Views.TestApi.Devices.Index({el: "#main"})
    app.current_view.render()

  contacts: =>
    @selectNav('contacts')
    app.current_view = new App.Views.TestApi.Contacts.Index({el: "#main"})
    app.current_view.render()
