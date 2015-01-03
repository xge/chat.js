app.controller "IndexController",
  class IndexController
    
    constructor: (@Socket) ->
      @messages = []
      @Socket.on 'news', (data) =>
        @messages.push data
