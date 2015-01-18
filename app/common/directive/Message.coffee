app.directive 'message', () ->
  return {
    replace: true
    restrict: 'A'
    scope: 'message': '=', 'username': '=', 'last': '='
    templateUrl: 'common/directive/Message.tpl.html'
    link: (scope) ->
  }
