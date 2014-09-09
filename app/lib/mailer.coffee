conf = require("../config")
sendgrid = require("sendgrid")
fs = require("fs")
path = require("path")
swig = require("swig")
emailTemplates = require("swig-email-templates")
_ = require("underscore")
_.str = require("underscore.string")
mailer = sendgrid(conf.get('mail').apiUser, conf.get('mail').apiKey)

# mailer.templates = {};
mailer._root = `undefined`
mailer._ext = `undefined`
mailer.setTemplateRoot = (root) ->
  mailer._root = root
  return

mailer.setTemplateExt = (ext) ->
  mailer._ext = ext
  return

mailer.compile = (callback) ->
  options = root: mailer._root
  emailTemplates options, (err, render) ->
    mailer._render = render
    callback()  if callback
    return

  return

mailer.render = (template, data, callback) ->
  template = template + mailer._ext
  data.baseUrl = conf.get('app').baseUrl
  data.env = conf.env
  mailer._render template, data, (err, result) ->
    return callback(err)  if err
    result = result.replace(/[\n\t]/g, "")
    callback null, result
    return

  return

mailer.preview = (template, data, callback) ->
  template = path.join(__dirname, "..", mailer._root) + "/" + template + mailer._ext
  tpl = swig.compileFile(template)
  result = tpl(data)
  result = result.replace(/[\n\t]/g, "")
  callback null, result
  return

mailer.sendTemplate = (template, data, callback) ->
  template = template + mailer._ext
  data.baseUrl = conf.get('app').baseUrl
  data.env = conf.env
  mailer._render template, data, (err, result) ->
    return callback(err)  if err
    result = result.replace(/[\n\t]/g, "")
    payload =
      to: data.to
      from: "contact@contextaware.io"
      subject: data.title
      html: result

    mailer.send payload, (err, json) ->
      return callback(err)  if err
      console.log "Email send!!!"
      callback null, json
      return

    return

  return

module.exports = mailer
