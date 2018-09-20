angular = require 'angular'
_ = require 'lodash'

app = angular.module 'gg'

app.component 'levelzero', {
  template: require('./levelzero.html.hamlc'),
  controller: (ailogdb) ->
    vm = @
    @mostrecententry = {}
    @mostrecenticeentry = {}
    @mostrecentpientry = {}
    @mostrecentzooentry = {}

    ailogdb.when_done =>
      entries = ailogdb.objects.entries
      @mostrecententry = {}
      @mostrecenttask = undefined

      sorted_entries = _.sortBy entries, (e) -> e.entered_at
      vm.entries = _.reverse sorted_entries
      console.log "populating vm.entries"

      for entry in vm.entries
        @mostrecententry[entry.name] = @mostrecententry[entry.name] or entry
        @mostrecenttask = @mostrecenttask or entry if entry.type == "task"

      vm.recent_entries = vm.entries[0..100]
    @
}
