db = require("../../../lib/db")
moment = require("moment")
_ = require("underscore")
_.str = require("underscore.string")
common = require("../../../config/common")
config = require("../../../config")
require "app/users"
User = db.model("user")

helpers = (swig) ->
  swig.setFilter "token", (resourse) ->
    if resourse.encrypt
      resourse.encrypt resourse.id
    else
      ""

  swig.setFilter "trimTo", (str, length) ->
    _.str.truncate str, length

  swig.setFilter "pad", (str, length) ->
    _.str.pad str, length, "0"

  swig.setFilter "can", (user, resourse, action) ->
    User::can.call user, resourse, action

  swig.setFilter "humanize", (resourse, format) ->
    moment(resourse.toString()).format format or "HH:mm DD-mm-YY"

  swig.setFilter "has", (array, index) ->
    array.indexOf(index) >= 0

  swig.setFilter "set_url", (resource) ->
    baseUrl = config.get("app").baseUrl.replace(/\/$/, '')
    resource = resource.replace(/^\//, "")

    return "#{baseUrl}/#{resource}"

  swig.setFilter "set_image_url", (resource) ->
    baseUrl = config.get("app").baseUrl.replace(/\/$/, '')
    media_url = config.get("media_url")
    resource = resource.replace(/^\//, "")

    return "#{baseUrl}/#{media_url}/#{resource}"

  swig.setFilter "set_string", (resource) ->
    return "#{resource}"


module.exports = helpers
