angular = require 'angular'
_ = require 'lodash'

app = angular.module 'slasher'

app.component 'levelzerored', {
  template: require('./levelzerored.html.hamlc'),
  controller: () ->
    vm = @
    @
}
