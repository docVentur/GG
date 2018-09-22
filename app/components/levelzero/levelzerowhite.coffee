angular = require 'angular'
_ = require 'lodash'

app = angular.module 'slasher'

app.component 'levelzerowhite', {
  template: require('./levelzerowhite.html.hamlc'),
  controller: () ->
    vm = @
    @
}
