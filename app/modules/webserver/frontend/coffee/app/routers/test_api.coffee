class App.Routers.TestApi extends Null.Routers.Base
  routes:
    '': 'index',
    'patients': 'patients'
    'surgeries': 'surgeries'
    'locations': 'locations'
    'messages': 'messages'
    'devices': 'devices'
    'contacts': 'contacts'

  $a = $("<a>")
  $a.attr('href', "")
  $a.data('role', 'route')

  index: =>
    @selectNav('')
    $a.html("Users")
    $('[data-role="breadcrum"]').html($a)
    app.loadPage App.Views.TestApi.Users.Index, {el: "[data-role=main]"}

  patients: =>
    @selectNav('patients')
    $a.html("Patients")
    $('[data-role="breadcrum"]').html($a)
    app.loadPage App.Views.TestApi.Patients.Index, {el: "[data-role=main]"}

  surgeries: =>
    @selectNav('surgeries')
    $a.html("Surgeries")
    $('[data-role="breadcrum"]').html($a)
    app.loadPage App.Views.TestApi.Surgeries.Index, {el: "[data-role=main]"}

  locations: =>
    @selectNav('locations')
    $a.html("Locations")
    $('[data-role="breadcrum"]').html($a)
    app.loadPage App.Views.TestApi.Locations.Index, {el: "[data-role=main]"}

  messages: =>
    @selectNav('messages')
    $a.html("Messages")
    $('[data-role="breadcrum"]').html($a)
    app.loadPage App.Views.TestApi.Messages.Index, {el: "[data-role=main]"}

  devices: =>
    @selectNav('devices')
    $a.html("Devices")
    $('[data-role="breadcrum"]').html($a)
    app.loadPage App.Views.TestApi.Devices.Index, {el: "[data-role=main]"}

  contacts: =>
    @selectNav('contacts')
    $a.html("Contacts")
    $('[data-role="breadcrum"]').html($a)
    app.loadPage App.Views.TestApi.Contacts.Index, {el: "[data-role=main]"}
