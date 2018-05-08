angular = require 'angular'
_ = require 'lodash'

app = angular.module 'gg'

app.service 'ggdb', (pouchDB, moment) ->
  @db = pouchDB 'http://clu:5984/ninja_pushy_cats/'



  @
