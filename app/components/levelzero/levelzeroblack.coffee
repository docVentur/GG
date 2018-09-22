angular = require 'angular'
_ = require 'lodash'

app = angular.module 'gg'

app.component 'levelzeroblack', {
  template: require('./levelzeroblack.html.hamlc'),
  controller: () ->
    vm = @
    @
}
