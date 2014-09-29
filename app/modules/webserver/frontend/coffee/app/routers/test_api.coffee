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
    app.loadPage App.Views.TestApi.Users.Index, {el: "[data-role=main]"}

  patients: =>
    @selectNav('patients')
    app.loadPage App.Views.TestApi.Patients.Index, {el: "[data-role=main]"}

  surgeries: =>
    @selectNav('surgeries')
    app.loadPage App.Views.TestApi.Surgeries.Index, {el: "[data-role=main]"}

  locations: =>
    @selectNav('locations')
    app.loadPage App.Views.TestApi.Locations.Index, {el: "[data-role=main]"}

  messages: =>
    @selectNav('messages')
    app.loadPage App.Views.TestApi.Messages.Index, {el: "[data-role=main]"}

  devices: =>
    @selectNav('devices')
    app.loadPage App.Views.TestApi.Devices.Index, {el: "[data-role=main]"}

  contacts: =>
    @selectNav('contacts')
    app.loadPage App.Views.TestApi.Contacts.Index, {el: "[data-role=main]"}
