angular = require 'angular'
_ = require 'lodash'

app = angular.module 'gg'

app.component 'levelzeropurple', {
  template: require('./levelzeropurple.html.hamlc'),
  controller: () ->
    vm = @
    @
}
