angular = require 'angular'
_ = require 'lodash'

app = angular.module 'ai.yellow.b00ks'

app.component 'ps102', {
  template: require('./ps102.html.hamlc'),
  controller: (aiyellowb00ksdb) ->
    vm = @
    @$onInit = ->
      aiyellowb00ksdb.create_entry "ps102"
    @
}
