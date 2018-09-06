angular = require 'angular'
_ = require 'lodash'

app = angular.module 'ai.yellow.b00ks'

app.component 'meadow', {
  template: require('./meadow.html.hamlc'),
  controller: (aiyellowb00ksdb) ->
    vm = @

    @$onInit = =>
      aiyellowb00ksdb.create_entry "meadow"
      console.log "Loaded into Meadow"

    @
}
