angular = require 'angular'
_ = require 'lodash'

app = angular.module 'ai.yellow.b00ks'

app.component 'fin218', {
  template: require('./fin218.html.hamlc'),
  controller: (aiyellowb00ksdb) ->
    vm = @
    @$onInit = ->
      aiyellowb00ksdb.create_entry "fin218"
    @
}
