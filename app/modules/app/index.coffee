# ORM requires this modules to load collections and then initialize the engine.
exports.models =
  Users: require "app/users/model"
