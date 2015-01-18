app.controller 'IndexController',
  class IndexController
    constructor: (@Socket) ->
      @username = ''
      @clist = []
      @messages = []
      @Socket.on 'msg', (data) =>
        @messages.push data
      @Socket.on 'new username', (name) =>
        @username = name
      @Socket.on 'clist changed', (clist) =>
        @clist = clist
    send: () ->
      @Socket.emit 'msg', new Message(new Date().getTime(), @username, @currentPayload)
      delete @currentPayload
