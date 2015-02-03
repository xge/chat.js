app.factory 'NotificationService', ($rootScope, $window) ->
  focused =  true
  $window.onfocus = () ->
    if(not focused)
      focused = true
      $rootScope.$broadcast 'denotify'
  $window.onblur = () ->
    focused = false
  notify: () ->
    if (not focused)
      $rootScope.$broadcast 'notify'