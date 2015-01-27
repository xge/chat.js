moment = require 'moment'

class Message
  constructor: (@timestamp = moment().valueOf(), @user, @payload) ->

exports = module.exports = Message
