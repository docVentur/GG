angular = require 'angular'
_ = require 'lodash'

app = angular.module 'gg'

app.component 'levelzerowhite', {
  template: require('./levelzerowhite.html.hamlc'),
  controller: () ->
    vm = @
    @
}
