angular = require 'angular'
_ = require 'lodash'

app = angular.module 'ai.yellow.b00ks'

app.component 'phe275', {
  template: require('./phe275.html.hamlc'),
  controller: (aiyellowb00ksdb) ->
    vm = @
    @$onInit = ->
      aiyellowb00ksdb.create_entry "phe275"
    @
}
