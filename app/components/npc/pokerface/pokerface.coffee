angular = require 'angular'
_ = require 'lodash'

app = angular.module 'gg'

app.component 'pokerface', {
  template: require('./pokerface.html.hamlc'),
  controller: (ailogdb) ->
    @
}
