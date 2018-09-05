angular = require 'angular'
_ = require 'lodash'

app = angular.module 'gg'

app.component 'npc', {
  template: require('./npc.html.hamlc'),
  controller: (ailogdb) ->
    @
}
