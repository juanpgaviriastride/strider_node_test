orm = require "../../../lib/orm"
BaseManager = require("null/models/base_manager")


class SurgeryController extends BaseManager
  model_identifier: 'surgery'



module.exports = SurgeryController
