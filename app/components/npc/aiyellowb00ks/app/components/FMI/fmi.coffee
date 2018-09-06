angular = require 'angular'
_ = require 'lodash'

app = angular.module 'ai.yellow.b00ks'

app.component 'fmi', {
  template: require('./fmi.html.hamlc')
  bindings: { 'recententries': '<' }
  controller: (aiyellowb00ksdb) ->
    vm = @

    aiyellowb00ksdb.create_entry "fmi"

    @$onInit = =>
      console.log "HAHAHAHA"
      console.log @recententries

    @showmethemoney = =>
      console.log "money shown"
      console.log @recententries

    @
}
