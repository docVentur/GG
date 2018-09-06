angular = require 'angular'
_ = require 'lodash'

app = angular.module 'gg'

app.component 'playingcardtachi', {
  template: require('./playingcardtachi.html.hamlc'),
  controller: (ailogdb) ->
    @
}
