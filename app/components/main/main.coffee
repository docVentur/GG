angular = require 'angular'
_ = require 'lodash'

app = angular.module 'gg'

app.component 'main', {
  template: require('./main.html.hamlc'),
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

      iceentries = ailogdb.objects.iceentries
      @mostrecenticeentry = {}
      @mostrecenticetask = undefined

      pientries = ailogdb.objects.pientries
      @mostrecentpientry = {}
      @mostrecentpitask = undefined

      zooentries = ailogdb.objects.zooentries
      @mostrecentzooentry = {}
      @mostrecentzootask = undefined

      hentries = ailogdb.objects.hentries
      @mostrecenthentry = {}
      @mostrecenthtask = undefined

      gobentries = ailogdb.objects.gobentries
      @mostrecentgobentry = {}
      @mostrecentgobtask = undefined


      sorted_entries = _.sortBy entries, (e) -> e.entered_at
      vm.entries = _.reverse sorted_entries
      console.log "populating vm.entries"

      for entry in vm.entries
        @mostrecententry[entry.name] = @mostrecententry[entry.name] or entry
        @mostrecenttask = @mostrecenttask or entry if entry.type == "task"

        if entry.type == "icetask"
          @mostrecenticeentry[entry.name] = @mostrecenticeentry[entry.name] or entry
          @mostrecenticetask = @mostrecenticetask or entry
        if entry.type == "pitask"
          @mostrecentpientry[entry.name] = @mostrecentpientry[entry.name] or entry
          @mostrecentpitask = @mostrecentpitask or entry
        if entry.type == "zootask"
          @mostrecentzooentry[entry.name] = @mostrecentzooentry[entry.name] or entry
          @mostrecentzootask = @mostrecentzootask or entry
        if entry.type == "htask"
          @mostrecenthentry[entry.name] = @mostrecenthentry[entry.name] or entry
          @mostrecenthtask = @mostrecenthtask or entry
        if entry.type == "gobtask"
          @mostrecentgobentry[entry.name] = @mostrecentgobentry[entry.name] or entry
          @mostrecentgobtask = @mostrecentgobtask or entry


      vm.recent_entries = vm.entries[0..100]
    @
}
