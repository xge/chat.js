app.directive 'avatar', () ->
  return {
    link: ($scope, el) ->
      angular.element('html, body').animate
        scrollTop: el.offset().top
      , 1000
}
