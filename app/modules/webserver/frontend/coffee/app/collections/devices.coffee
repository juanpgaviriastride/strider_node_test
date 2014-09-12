class App.Collections.Devices extends System.Collections.Base
  url: '/api/v1/devices'
  model: App.Models.Devices

class App.Collections.DevicesRequestToken extends System.Collections.Base
  url: '/api/v1/auth/devices/request_token'
  model: App.Models.DevicesRequestToken
