config = require('../../../config')
crypto = require 'crypto'
Waterline = require("waterline")

makeSalt = () ->
  return Math.round((new Date().valueOf() * Math.random())) + ''

encryptPassword = (password, salt) ->
  return crypto.createHmac('sha1', salt).update(password).digest('hex')


User = Waterline.Collection.extend(
  identity: 'user'
  connection: 'couchdb'

  attributes:{

    id: { type: 'string', primaryKey: true, unique: true }

    username:        {type: 'string', required: yes, unique: yes}
    hashed_password: {type: 'string'}
    password:        () => @_password # Supporting old frameworks. TODO: Remove this
    salt:            {type: 'string'}
    apn_token:       {type: 'string', unique: yes}
    active:          {type: 'boolean', defaultsTo: yes}

    ssn:      {type: 'string', required: no}

    #name:
    prefix_name: {type: 'string', required: no}
    first_name:  {type: 'string', required: no}
    last_name:   {type: 'string', required: no}

    dob:            () => @createdAt
    profileUrl:     {type: 'string', required: no}
    role:           {type: 'string', required: no}

    #contactInfo:
    ## phone:
    office_phone:   {type: 'string', required: no}
    cell_phone:     {type: 'string', required: no}

    #email:
    personal_email: {type: 'string', required: no}
    work_email:     {type: 'string', required: no}

    ##Instance methods

    authenticate: (plainText) ->
      return encryptPassword(plainText, @salt) == @hashed_password
  } # end attributes

## Class methods
  beforeCreate: (values, next) =>
    @_password = values.password
    delete values.password
    values.salt = makeSalt()
    values.hashed_password = encryptPassword(@_password, values.salt)
    next()
) # end collection

module.exports = User


# MISSING FROM MONGOOSE MODEL

# User.virtual('token').get(() ->
#   return @_token
# )

# User.virtual('token').set((token) ->
#   console.log "SET TOKEN: ", token
#   @_token = token
#   return
# )
