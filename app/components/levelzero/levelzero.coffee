angular = require 'angular'
_ = require 'lodash'

app = angular.module 'gg'

app.component 'levelzero', {
  template: require('./levelzero.html.hamlc'),
  bindings:
    slashergame: '<'
  controller: () ->
    vm = @
    @
}
