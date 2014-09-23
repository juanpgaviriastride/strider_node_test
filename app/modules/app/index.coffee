# ORM requires this modules to load collections and then initialize the engine.
exports.models =
  AuthToken: require "app/auth_token/model"
  Users: require "app/users/model"
  Locations: require "app/locations/model"
  Messages: require "app/messages/model"
  Surgeries: require "app/surgeries/model"
  Patients: require "app/patients/model"
  Devices: require "app/devices/model"
  DevicesTokenRequest: require("app/devices/model").TokenRequest
  Contacts: require "app/contacts/model"
