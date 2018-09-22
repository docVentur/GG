angular = require 'angular'
_ = require 'lodash'

app = angular.module 'slasher'

app.component 'levelzeroblack', {
  template: require('./levelzeroblack.html.hamlc'),
  controller: () ->
    vm = @
    @
}
