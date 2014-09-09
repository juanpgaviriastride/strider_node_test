Notification = require "./model"
BaseController = require "null/controller/base"
async = require "async"

class NotificationController extends BaseController
  model: Notification

  create: (data, callback) ->
    console.log " create new notificaiton ", data
    # try to find alredy existed notification
    # if so, we update it (in order not to have several notifications about single load)
    async.waterfall [
      (cb) ->
        console.log "  check for old notificaiton "
        Notification.findOne {user_id: data.user_id, resource_id: data.resource_id}, cb
      (old_notification, cb) ->
        console.log "  update/create notification"
        if old_notification
          old_notification.set data
          old_notification.save cb
        else
          new_notification = new Notification data
          new_notification.save cb
    ], (err, result) ->
      console.log "  final new notification: ", result
      callback err, result

module.exports = new NotificationController()