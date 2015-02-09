app = angular.module 'chat', [
  'btford.socket-io'
  'chat.tpl'
  'ngEmoticons'
  'ngSanitize'
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

# CONSTANTS is copied via grunt. AWESOME!
app.constant 'CONST', CONSTANTS