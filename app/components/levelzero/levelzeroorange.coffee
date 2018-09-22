angular = require 'angular'
_ = require 'lodash'

app = angular.module 'gg'

app.component 'levelzeroorange', {
  template: require('./levelzeroorange.html.hamlc'),
  controller: () ->
    vm = @
    @
}
