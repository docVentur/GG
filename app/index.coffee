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

app = angular.module 'gg', [
  'ui.router',
  'ngAnimate',
  'pouchdb',
  angularMaterialize,
  'angularMoment'
]

require './services/npc.css'
# future iterations will use gg-library/gg.css

require './services/services.coffee'
require './components/components.coffee'

app.config ($stateProvider, $urlRouterProvider) ->
#  $stateProvider.state {name: 'layout', template: require('gg-css/gg-layout.html.hamlc')}

  $stateProvider.state {name: 'layout', template: require('./layout.html.hamlc')}
  $stateProvider.state {name: 'main', url: '/main', parent: 'layout', component: 'main'}
  $stateProvider.state {name: 'npc', url: '/npc', parent: 'main', component: 'npc'}

  $urlRouterProvider.when '', '/main'
