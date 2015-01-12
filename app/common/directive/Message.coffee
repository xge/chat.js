app.directive 'message', () ->
  return {
    restrict: 'A'
    scope: 'message': '='
    templateUrl: 'common/directive/Message.tpl.html'
    link: (scope) ->
  }
