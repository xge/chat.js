app.controller 'SoundNotificationController',
  class SoundNotificationController
    constructor: ($scope) ->
      $scope.$on 'notify', () ->
        # SUUUPER DIRRRTY
        angular.element('#audioNotifier')[0].play()