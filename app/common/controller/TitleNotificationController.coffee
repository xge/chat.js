app.controller 'TitleNotificationController',
  class TitleNotificationController
    constructor: ($scope) ->
      @defaultTitle = 'chat.js'
      @title = @defaultTitle
      $scope.$on 'notify', () =>
        @title = "★ #{ @defaultTitle }"
      $scope.$on 'denotify', () =>
        @title = @defaultTitle