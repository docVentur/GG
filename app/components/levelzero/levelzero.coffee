angular = require 'angular'
_ = require 'lodash'

app = angular.module 'slasher'

app.component 'levelzero', {
  template: require('./levelzero.html.hamlc'),
  bindings:
    slashergame: '<'
  controller: () ->
    vm = @
    @
}
