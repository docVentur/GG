angular = require 'angular'
_ = require 'lodash'

app = angular.module 'gg'

app.component 'levelzerored', {
  template: require('./levelzerored.html.hamlc'),
  controller: () ->
    vm = @
    @
}
