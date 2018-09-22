angular = require 'angular'
_ = require 'lodash'

app = angular.module 'slasher'

app.component 'levelzeropink', {
  template: require('./levelzeropink.html.hamlc'),
  controller: () ->
    vm = @
    @
}
