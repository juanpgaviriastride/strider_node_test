require 'mongoose-pagination'
User = require "./model"
HTTPStatus = require "http-status"
config = require('../../../config')
async = require "async"
BaseController = require("null/controller/base")
_ = require 'underscore'
orm = require "../../../lib/orm"


class UserController
  constructor: (options) ->
    @initialize options

  initialize: (options) =>
    #SMELL: make this a lazy evaluation of a config string?
    @model = orm.models.user
    return

  create: (params..., callback) =>
    [data, options] = params

    new_object = @model.create(data)
    new_object.exec (err, obj) ->
      console.log obj
      callback err, obj

  deleteOne: (query, callback) =>
    console.log "DELETING", query
    @model.destroy query, (err, res) ->
      console.log "DEL RES: ", res, err
      callback err, res

  updateOne: (params..., callback) =>
    [data, options] = params
    id = data.id
    delete data.id
    @model.merge id, data, (err, result) ->
      callback err, result

  populateQuery: (query, populate) =>
    for key, value of populate
      query = query.populate(key, value.join(' '))

    return query


  getOne: (params..., callback) =>
    [query, fields, populate] = params
    query_obj = @model.findOne().where(query)


    # FIXME:
    #
    # TODO: Create adapter show method to support field selection
    # http://stackoverflow.com/questions/7409026/get-a-single-value-from-document
    #
    #
    #if fields?
    #  query_obj = query_obj.select(fields)
    #if populate?
    #  query_obj = @populateQuery(query_obj, populate)

    query_obj.exec (err, result) ->
      console.log result
      callback err, result

  getAll: (query, callback) =>
    console.log "getAll #{@model}"
    console.log orm
    @model.find query, (err, results) ->
      for result, index in results
        results[index] = result
      return callback(err, results)

  filter: (options..., callback) =>
    console.log "Filter"
    console.log "@model: #{@model}"
    console.log "orm:"
    console.log orm

    that = @
    [query, fields, populate, page, limit, sort_field, sort_direction] = options

    queryset = @model.find(query)
    #if fields? and fields.length > 0
    #  queryset = queryset.select(fields)
    #if populate?
    #  queryset = @populateQuery(queryset, populate)

    if page and limit
      count = @model.find(query)
      queryset = queryset.paginate(page, limit)

    if sort_field
      sort = {}
      if sort_direction and not isNaN(parseInt(sort_direction))
        sort[sort_field] = parseInt(sort_direction)
      else
        sort[sort_field] = -1
      queryset = queryset.sort(sort)

    async.series({
      count: (cb) =>
        if count
          #console.log "COUNT COUNT COUNT"
          #console.log count
          #count.count( (err, count) =>
          #  cb(null, count)
          #)
          cb(null, null)
        else
          cb(null, null)
      ,
      queryset: (cb) =>
        queryset.exec( (error, result) =>
          if typeof callback == "function"
            cb(error, result)
        )
      ,
    },(err, res) =>
      callback(err, res)
    )

module.exports = UserController
