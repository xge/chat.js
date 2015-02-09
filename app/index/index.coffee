app.controller 'IndexController',
  class IndexController
    constructor: ($filter, CONST, Socket, HtmlHelper, NotificationService) ->
      # ###
      # Initialize properties
      # ###
      @$filter = $filter
      @Socket = Socket
      @HtmlHelper = HtmlHelper
      @has_error = false
      @username = ''
      @clist = []
      @messages = []
      EVENTS = CONST.EVENTS

      # ###
      # Socket.io setup
      # ###

      # Receive message
      @Socket.on EVENTS.MESSAGE, (data) =>
        @messages.push new Message(
          $filter('date')(data.timestamp, CONST.DATE_FORMAT)
          data.user
          @sanitize data.payload
        )
        NotificationService.notify()

      # User connects
      @Socket.on EVENTS.CONNECT, () =>
        @has_error = false

      # Connection to the backend is lost
      @Socket.on 'connect_error', () =>
        @has_error = true

      # Backend assigns username
      @Socket.on EVENTS.USER_NEW, (name) =>
        @username = name

      # Clist changed (e.g. user joins/leaves)
      @Socket.on EVENTS.CLIST_UPDATE, (clist) =>
        @clist = clist

      # User joins
      @Socket.on EVENTS.ANNOUNCE_JOIN, (data) =>
        @messages.push new Message(
          $filter('date')(data.timestamp, CONST.DATE_FORMAT)
          data.user
          "#{ data.payload } joined the conversation."
          'announcement'
        )

      # User leaves
      @Socket.on EVENTS.ANNOUNCE_LEAVE, (data) =>
        @messages.push new Message(
          $filter('date')(data.timestamp, CONST.DATE_FORMAT)
          data.user
          "#{ data.payload } left the conversation."
          'announcement'
        )

    # Adds links and emoticons to the string.
    #
    # @param [String] text the message to convert
    #
    # @return [String] ready-to-use HTML
    sanitize: (text) ->
      text = @$filter('linky')(text, '_blank')
      text = @$filter('emoticons')(text)

    # Submit `@currentPayload` to the backend.
    send: () ->
      @Socket.emit 'msg', new Message(
        null
        @username
        @currentPayload
      )
      delete @currentPayload
