angular = require 'angular'
_ = require 'lodash'

app = angular.module 'slasher'

app.component 'levelzeropurple', {
  template: require('./levelzeropurple.html.hamlc'),
  controller: () ->
    vm = @
    @
}
