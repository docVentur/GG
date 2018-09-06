angular = require 'angular'
_ = require 'lodash'

app = angular.module 'gg'

app.component 'pushyf00tmap', {
  template: require('./pushyf00tmap.coffee'),
  controller: (ailogdb) ->
    @
}
