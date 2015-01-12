app = angular.module 'chat', [
  'btford.socket-io',
  'chat.tpl',
  'ngRoute'
]

app.config [
  '$routeProvider',
  ($routeProvider) ->
    $routeProvider.when '/',
      templateUrl: 'index/index.tpl.html'
    .otherwise
      redirectTo: '/'
]
