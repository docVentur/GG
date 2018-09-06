angular = require 'angular'
_ = require 'lodash'

app = angular.module 'ai.yellow.b00ks'

app.component 'testing', {
  template: require('./testing.html.hamlc')
  bindings: { 'lessrecententries': '<' }
  controller: (aiyellowb00ksdb) ->
    vm = @

    aiyellowb00ksdb.create_entry "testing"

    @$onInit = =>
      console.log "HAHAHAHA"
      console.log @lessrecententries

    @showmethemoney = =>
      console.log "money shown"
      console.log @lessrecententries

    @
}
