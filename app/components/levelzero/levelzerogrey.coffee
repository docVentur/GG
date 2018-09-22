angular = require 'angular'
_ = require 'lodash'

app = angular.module 'gg'

app.component 'levelzerogrey', {
  template: require('./levelzerogrey.html.hamlc'),
  controller: () ->
    vm = @
    @
}
