BaseResource = require "null/api/base"
db = require "../../../../lib/nano_db"
config = require '../../../../config'


class OembedResource extends BaseResource
  controller_class: null
  populate: {}

  initialize: (options) =>
    return

  detail: (req, res, next) =>
    urlRegEx = new RegExp "^http:\/\/localhost:3000\/api/v1/assets\/(.*)"
    matched = urlRegEx.exec(req.oembed.url)
    doc_id = matched[1]

    assets = db("asset")

    assets.get(doc_id, { revs_info: true }, (err, body) =>
      console.log "ASSET: ", err, body
      return res.satus(400).json({error: "asset not found"}) unless body._attachments?.blob?.content_type?
      if body._attachments?.blob?.content_type.match("^image")
        res.oembed.photo(
          "http://#{config.get('app').host}:#{config.get('app').port}/api/v1/assets/#{doc_id}",
          256,
          256,
          {
            author_name: body.author
            caption: body.caption
            description: body.description
          }
        )
      else if body._attachments?.blob?.content_type.match("^video")
        res.oembed.video(
          """
          <video width="320" height="240" controls>
            <source src="http://#{config.get('app').host}:#{config.get('app').port}/api/v1/assets/#{doc_id}" type="video/mp4">
            Your browser does not support the video tag.
          </video>
          """
          480,
          360
        )
    )



module.exports = OembedResource
