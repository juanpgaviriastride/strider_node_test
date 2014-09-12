BaseResource = require "null/api/base"
Devices = require "app/devices"

class DeviceResource extends BaseResource
  controller_class: Devices
  populate: {}
  fields: []

  create: (req, res, next) =>
    data =
      token_request: req.params.request_token
      data: req.body
    req.body = data

    super


class DeviceTokenRequestResource extends BaseResource
  controller_class: Devices.TokenRequestController
  populate: {}


module.exports = DeviceResource
module.exports.TokenRequestResource = DeviceTokenRequestResource
