angular = require 'angular'
_ = require 'lodash'

app = angular.module 'gg'

app.component 'levelzeroyellow', {
  template: require('./levelzeroyellow.html.hamlc'),
  controller: () ->
    vm = @
    @
}
