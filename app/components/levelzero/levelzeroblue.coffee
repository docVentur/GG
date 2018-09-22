angular = require 'angular'
_ = require 'lodash'

app = angular.module 'gg'

app.component 'levelzeroblue', {
  template: require('./levelzeroblue.html.hamlc'),
  controller: () ->
    vm = @
    @
}
