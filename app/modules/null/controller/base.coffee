require 'mongoose-pagination'
async = require("async")

class BaseController
  # Mongoose model class
  model: {}

  constructor: (options) ->
    @initialize(options)
  ,

  initialize: (options) =>
    return
  ,

  getAll: (query, callback) =>
    console.log "BASE GETALL"
    @model.find query, (err, results) ->
      for result, index in results
        results[index] = result.filter()
      return callback(err, results)
  ,

  filter: (options..., callback) =>
    that = @
    [query, fields, populate, page, limit, sort_field, sort_direction] = options

    queryset = @model.find(query)
    if fields? and fields.length > 0
      queryset = queryset.select(fields)
    if populate?
      queryset = @populateQuery(queryset, populate)
      
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
          count.count( (err, count) =>
            cb(null, count)
          )
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


    return
  ,

  getOne: (params..., callback) =>
    [query, fields, populate] = params
    query_obj = @model.findOne(query)
    if fields?
      query_obj = query_obj.select(fields)
    if populate?
      query_obj = @populateQuery(query_obj, populate)
      
    query_obj.exec (err, result) ->
      callback err, result
  ,

  getOneRaw: (query, callback) =>
    @model.findOne query, (err, result) ->
      callback err, result
  ,

  populateQuery: (query, populate) =>
    for key, value of populate
      query = query.populate(key, value.join(' '))
    
    return query
  ,
  
  create: (params..., callback) =>
    [data, options] = params

    new_object = new @model(data)
    new_object.save (err, obj) ->
      callback err, obj
  ,

  updateOne: (params..., callback) =>
    [data, options] = params

    @model.updateOne data, (err, result) ->
      callback err, result
  ,

  deleteOne: (query, callback) =>
    @model.deleteOne query, callback
  ,


module.exports = BaseController
