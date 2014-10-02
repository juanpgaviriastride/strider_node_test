class App.Collections.Devices extends Null.Collections.Base
  url: '/api/v1/devices'
  model: App.Models.Device

class App.Collections.DevicesRequestToken extends Null.Collections.Base
  url: '/api/v1/auth/devices/request_token'
  model: App.Models.DevicesRequestToken
