machina = require('machina')
angular = require 'angular'
_ = require 'lodash'

npc_fsm = {
  namespace: "gg",
  initialState: "bliss",
  states: {
    bliss: {
      _onEnter: (stats) ->
        console.log "Entered the bliss state."
      'tick': (stats) ->
        console.log "Handle a blissful tick()"
        stats.number = stats.number + 1
        if stats.number > 10
          @transition stats, 'mono'
    },
    mono: {
      _onEnter: (stats) ->
        console.log "Entered mono."
      'tick': (stats) ->
        console.log "Handle a diabetic tick()"
        stats.number = stats.number + 1
        if stats.number > 20
          @transition stats, 'sudo'
    },
    sudo: {
      _onEnter: (stats) ->
        console.log "Entered sudo."
      'tick': (stats) ->
        console.log "Handle a diabetic tick()"
        stats.number = stats.number + 1
        if stats.number > 30
          @transition stats, 'sudo'

    }
    dotowo: {
      _onEnter: (stats) ->
        console.log "Entered dotowo"
      'tick': (stats) ->
        console.log "Handle a diabetic tick()"
        stats.number = stats.number + 1
        if stats.number > 30
          @transition stats, 'tsugu'
    }

    tsugu: {
      _onEnter: (stats) ->
        console.log "kudos! END OF CURRENT CONTENT <3 more coming s00n! <3"
    }

  },

  init_npc: () ->
    console.log "initializing Ninja Pushy Cats: CATasTROPHY"
    npc = {number: 0}
    @handle npc, 'tick'
    return npc

  tick: (npc) ->
    @handle npc 'tick'
}


app = angular.module 'npc'

app.service 'npc_fsm', (pouchDB, moment) ->
  return new machina.BehavioralFsm npc_fsm
