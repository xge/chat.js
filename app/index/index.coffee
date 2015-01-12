app.controller 'IndexController',
  class IndexController
    constructor: (@Socket) ->
      @messages = []
      @Socket.on 'msg', (data) =>
        @messages.push data
    send: () ->
      msg = new Message(moment().valueOf(), 'User', @currentPayload)
      @messages.push msg
      delete @currentPayload
      @Socket.emit 'msg', msg
