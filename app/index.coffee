angular = require 'angular'
_ = require 'lodash'
uiRouter  = require '@uirouter/angularjs'
ngAnimate = require 'angular-animate'
require 'expose-loader?PouchDB!pouchdb'
pdb = require 'angular-pouchdb'
angularMaterialize = require 'angular-materialize'
require 'angular-moment'

require('materialize-css/dist/css/materialize.css')
require('materialize-css/dist/js/materialize.js')

app = angular.module 'gg', [
  'ui.router',
  'ngAnimate',
  'pouchdb',
  'ui.materialize',
  'angularMoment'
]

require './services/npc.css'
# gave up on parallax 9/20/2018
# future iterations will use gg-library/gg.css

require './services/services.coffee'
require './components/components.coffee'

app.config ($stateProvider, $urlRouterProvider) ->
  get_recent_entries = (aiyellowb00ksdb) ->
    aiyellowb00ksdb.recent_entries()
      .then (results) ->
        docs = _.map results.rows, (v, i, r) -> v.doc
        return Promise.resolve docs
      .catch (error) ->
        console.log "it BROKE"
        console.log error

  get_less_recent_entries = (aiyellowb00ksdb) ->
    aiyellowb00ksdb.less_recent_entries()
      .then (results) ->
        docs = _.map results.rows, (v, i, r) -> v.doc
        return Promise.resolve docs
      .catch (error) ->
        console.log "it BROKE"
        console.log error

app.config ($stateProvider, $urlRouterProvider) ->
#  $stateProvider.state {name: 'layout', template: require('gg-css/gg-layout.html.hamlc')}

  $stateProvider.state {name: 'layout', template: require('./layout.html.hamlc')}
  $stateProvider.state {name: 'levelzero', url: '/levelzero', component: 'levelzero'}
  $stateProvider.state {name: 'main', url: '/main', parent: 'layout', component: 'main'}
  $stateProvider.state {name: 'npc', url: '/npc', parent: 'main', component: 'npc'}

#  $stateProvider.state {name: 'aiyellowb00ks', url: '/npc/aiyellowb00ks', parent: 'npc', component: 'aiyellowb00ks'}
#  $stateProvider.state {name: 'playingcardtachi', url: '/npc/playingcardtachi', parent: 'npc', component: 'playingcardtachi'}
#  $stateProvider.state {name: 'catastrophy', url: '/npc/catastrophy', parent: 'npc', component: 'catastrophy'}
#  $stateProvider.state {name: 'pokerface', url: '/npc/pokerface', parent: 'npc', component: 'pokerface'}
#  $stateProvider.state {name: 'pushyf00tmap', url: '/npc/pushyf00tmap', parent: 'npc', component: 'pushyf00tmap'}
#  $stateProvider.state {name: 'sudoku', url: '/npc/sudoku', parent: 'npc', component: 'sudoku'}


  $stateProvider.state {name: 'aiyellowb00kslayout', parent: 'main', url: '/aiyellowb00kslayout', template: require('./components/npc/aiyellowb00ks/app/aiyellowb00kslayout.html.hamlc')}

  $urlRouterProvider.when '', '/levelzero'

#  $stateProvider.state {name: 'main', url: '/main', parent: 'layout', template: require('./main.html.hamlc')}
#  $stateProvider.state {name: 'beginning', url: '/beginning', parent: 'meadow', component: 'beginning'}
#  $stateProvider.state {name: 'middle', url: '/middle', parent: 'meadow', component: 'middle'}
#  $stateProvider.state {name: 'fin', url: '/fin', parent: 'meadow', component: 'fin'}
#  $stateProvider.state {name: 'meadow', url: '/meadow', parent: 'layout', component: 'meadow'}

#  $stateProvider.state {name: 'fmi', url: '/fmi', parent: 'meadow', component: 'fmi', resolve: {'recententries': get_recent_entries}}
#  $stateProvider.state {name: 'testing', url: '/testing', parent: 'meadow', component: 'testing', resolve: {'lessrecententries': get_less_recent_entries}}

#  $stateProvider.state {name: 'mus129', url: '/mus129', parent: 'layout', component: 'mus129'}
#  $stateProvider.state {name: 'fin218', url: '/fin218', parent: 'layout', component: 'fin218'}
#  $stateProvider.state {name: 'mgmt299', url: '/mgmt299', parent: 'layout', component: 'mgmt299'}
#  $stateProvider.state {name: 'phe275', url: '/phe275', parent: 'layout', component: 'phe275'}
#  $stateProvider.state {name: 'ps102', url: '/ps102', parent: 'layout', component: 'ps102'}
#  $stateProvider.state {name: 'gg_gg', url: '/gg_gg', parent: 'layout', component: 'gggg'}
