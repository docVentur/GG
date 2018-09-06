angular = require 'angular'
_ = require 'lodash'

app = angular.module 'gg'

app.component 'sudoku', {
  template: require('./sudoku.html.hamlc'),
  controller: (ailogdb) ->
    @
}
