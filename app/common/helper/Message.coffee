class Message
  constructor: (timestamp = new Date().getTime(), user, payload, type = 'msg') ->
    @timestamp = timestamp
    @user = user
    @payload = payload
    @type = type
