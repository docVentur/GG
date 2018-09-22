angular = require 'angular'
_ = require 'lodash'

app = angular.module 'slasher'

app.component 'levelzerogrey', {
  template: require('./levelzerogrey.html.hamlc'),
  controller: () ->
    vm = @
    @
}
