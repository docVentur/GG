angular = require 'angular'
_ = require 'lodash'

app = angular.module 'slasher'

app.component 'levelzeroblue', {
  template: require('./levelzeroblue.html.hamlc'),
  controller: () ->
    vm = @
    @
}
