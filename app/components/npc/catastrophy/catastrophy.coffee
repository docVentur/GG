angular = require 'angular'
_ = require 'lodash'

app = angular.module 'gg'

app.component 'catastrophy', {
  template: require('./catastrophy.html.hamlc'),
  controller: (ailogdb) ->
    @
}
