angular = require 'angular'
_ = require 'lodash'
uiRouter  = require '@uirouter/angularjs'
ngAnimate = require 'angular-animate'
require 'expose-loader?PouchDB!pouchdb'
pdb = require 'angular-pouchdb'
angularMaterialize = require 'angular-materialize'
require 'angular-moment'

require('materialize-css/bin/materialize.css')
require('materialize-css/bin/materialize.js')

require './ai.yellow.b00ks.css'

require 'gg-css/gg.css'

app = angular.module 'ai.yellow.b00ks', [
  'ui.router',
  'ngAnimate',
  'pouchdb',
  angularMaterialize,
  'angularMoment'
]

require './services/services.coffee'
require './components/components.coffee'
require 'gg-css/gg.css'

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


  $stateProvider.state {name: 'layout', template: require('./layout.html.hamlc')}

  $stateProvider.state {name: 'main', url: '/main', parent: 'layout', template: require('./main.html.hamlc')}
  $stateProvider.state {name: 'beginning', url: '/beginning', parent: 'meadow', component: 'beginning'}
  $stateProvider.state {name: 'middle', url: '/middle', parent: 'meadow', component: 'middle'}
  $stateProvider.state {name: 'fin', url: '/fin', parent: 'meadow', component: 'fin'}
  $stateProvider.state {name: 'meadow', url: '/meadow', parent: 'layout', component: 'meadow'}

  $stateProvider.state {name: 'fmi', url: '/fmi', parent: 'meadow', component: 'fmi', resolve: {'recententries': get_recent_entries}}
  $stateProvider.state {name: 'testing', url: '/testing', parent: 'meadow', component: 'testing', resolve: {'lessrecententries': get_less_recent_entries}}



  $stateProvider.state {name: 'mus129', url: '/mus129', parent: 'layout', component: 'mus129'}
  $stateProvider.state {name: 'fin218', url: '/fin218', parent: 'layout', component: 'fin218'}
  $stateProvider.state {name: 'mgmt299', url: '/mgmt299', parent: 'layout', component: 'mgmt299'}
  $stateProvider.state {name: 'phe275', url: '/phe275', parent: 'layout', component: 'phe275'}
  $stateProvider.state {name: 'ps102', url: '/ps102', parent: 'layout', component: 'ps102'}
  $stateProvider.state {name: 'gg_gg', url: '/gg_gg', parent: 'layout', component: 'gggg'}

  $urlRouterProvider.when '', '/main'
