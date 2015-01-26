app.controller 'IndexController',
  class IndexController
    constructor: (@$filter, @Socket, @HtmlHelper) ->
      @username = ''
      @clist = []
      @messages = []
      @Socket.on 'msg', (data) =>
        @messages.push new Message(data.timestamp, data.user, $filter('emoticons')(data.payload))
      @Socket.on 'new username', (name) =>
        @username = name
      @Socket.on 'clist changed', (clist) =>
        @clist = clist
    send: () ->
      @Socket.emit 'msg', new Message(new Date().getTime(), @username, @HtmlHelper.htmlEntities @currentPayload)
      delete @currentPayload
