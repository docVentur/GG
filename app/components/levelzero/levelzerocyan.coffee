angular = require 'angular'
_ = require 'lodash'

app = angular.module 'slasher'

app.component 'levelzerocyan', {
  template: require('./levelzerocyan.html.hamlc'),
  controller: () ->
    vm = @
    @
}
