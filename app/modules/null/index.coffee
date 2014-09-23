# ORM requires this modules to load collections and then initialize the engine.
exports.models =
  Jobs: require "null/jobs/model"
  Cron: require("null/jobs/model").Cron
