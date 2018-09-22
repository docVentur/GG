angular = require 'angular'
_ = require 'lodash'

app = angular.module 'gg'

app.component 'levelzerobrown', {
  template: require('./levelzerobrown.html.hamlc'),
  controller: () ->
    vm = @
    @
}
