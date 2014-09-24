config = require('../../../config')
orm = require "../../../lib/orm"
BaseManager = require("null/models/base_manager")

Users = require "app/users"

async = require "async"

class ContactController extends BaseManager
  model_identifier: 'contact'
  
  create: (params..., callback) =>
    [data, options] = params

    users = new Users()
    users.getOne {id: data.contact_id}, (err, res) =>
      console.log "contact USER: ", err, res
      data.contact_username = res.username
      data.contact_name = res.full_name()
      console.log "Contact data: ", data
      super data, options, callback




module.exports = ContactController
