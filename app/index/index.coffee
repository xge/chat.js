app.controller "IndexController",
  class IndexController

    constructor: (@Socket) ->
      @messages = []
      @Socket.on 'msg', (data) =>
        @messages.push data
    send: () ->
      msg =
        timestamp: moment().valueOf()
        user: "User"
        payload: @currentPayload,
      @messages.push msg
      delete @currentPayload
      @Socket.emit 'msg', msg
