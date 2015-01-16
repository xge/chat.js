app.controller 'IndexController',
  class IndexController
    constructor: (@$scope, @Socket) ->
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
      @Socket.emit 'msg', new Message(moment().valueOf(), @username, @currentPayload)
      delete @currentPayload
