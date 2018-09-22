angular = require 'angular'
_ = require 'lodash'

app = angular.module 'gg'

app.component 'levelzeropink', {
  template: require('./levelzeropink.html.hamlc'),
  controller: () ->
    vm = @
    @
}
