angular = require 'angular'
_ = require 'lodash'
uiRouter  = require '@uirouter/angularjs'
ngAnimate = require 'angular-animate'
require 'expose-loader?PouchDB!pouchdb'
pdb = require 'angular-pouchdb'
angularMaterialize = require 'angular-materialize'

require('materialize-css/bin/materialize.css')
require('materialize-css/bin/materialize.js')


require 'gg-css/gg.css'

app = angular.module 'gg', [
  'ui.router',
  'ngAnimate',
  'pouchdb',
  angularMaterialize,
]

require './services/services.coffee'
require './components/components.coffee'


app.config ($stateProvider, $urlRouterProvider) ->
  $stateProvider.state {name: 'layout', template: require('./layout.html.hamlc')}
  $stateProvider.state {name: 'main', url: '', parent: 'layout', template: require('./components/main.html.hamlc')}


  $urlRouterProvider.when '', '/main'
