class Message
  constructor: (@timestamp = new Date().getTime(), @user, @payload, @type = 'msg') ->
