angular = require 'angular'
_ = require 'lodash'

app = angular.module 'ai.yellow.b00ks'

app.component 'beginning', {
  template: require('./beginning.html.hamlc'),
  controller: (aiyellowb00ksdb) ->
    vm = @
    @$onInit = ->
      aiyellowb00ksdb.create_entry "beginning"

    @number_after = (value) ->
      return value + 1

    @
}
