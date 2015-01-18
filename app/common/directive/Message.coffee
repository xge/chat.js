app.directive 'message', () ->
  return {
    replace: true
    restrict: 'A'
    scope: 'message': '=', 'username': '='
    templateUrl: 'common/directive/Message.tpl.html'
    link: (scope) ->
  }
