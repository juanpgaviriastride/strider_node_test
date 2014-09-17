# ORM requires this modules to load collections and then initialize the engine.
exports.models =
  AuthToken: require "app/auth_token/model"
  Users: require "app/users/model"
  Locations: require "app/locations/model"
  Messages: require "app/messages/model"
