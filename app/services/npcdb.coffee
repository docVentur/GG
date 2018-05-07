angular = require 'angular'
_ = require 'lodash'

app = angular.module 'npc'

app.service 'npcdb', (pouchDB, moment) ->
  @db = pouchDB 'http://clu:5984/ninja_pushy_cats/'



  @
