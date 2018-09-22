angular = require 'angular'
_ = require 'lodash'

app = angular.module 'gg'

app.component 'levelzerogreen', {
  template: require('./levelzerogreen.html.hamlc'),
  controller: () ->
    vm = @
    @
}
