angular = require 'angular'
_ = require 'lodash'

app = angular.module 'slasher'

app.component 'levelzerogreen', {
  template: require('./levelzerogreen.html.hamlc'),
  controller: () ->
    vm = @
    @
}
