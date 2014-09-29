BaseResource = require "null/api/base"
Contacts = require "app/contacts"

class ContactResource extends BaseResource
  controller_class: Contacts
  populate: {}

  list: (req, res, next) =>
    req.query.user ||= req.user?.id
    super

  create: (req, res, next) =>
    req.body.user = req.user.id
    super


module.exports = ContactResource
