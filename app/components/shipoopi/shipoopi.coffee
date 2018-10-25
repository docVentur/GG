angular = require 'angular'
_ = require 'lodash'

app = angular.module 'gg'

app.component 'shipoopi', {
  template: require('./shipoopi.html.hamlc'),
  controller: (maibackend, ailogdb, $http) ->
    vm = @

    $http.defaults.headers.post["Content-Type"] = "text/plain"

    apikey = maibackend.mel_apikey

    @users_by_id = {}

    @entry_type_ids_by_name = {}
    @most_recent_by_type = {}
    @log_entry_type_id_by_name = {}
    @log_entries = []
    @domains = []
    @log_entry_types = []

    @reload_domains = ->
      vm.domain_ids_by_name = {}
      vm.domains = maibackend.Domain.query({apikey: apikey})
      vm.domains.$promise.then (data) ->
        for domain in data
          vm.domain_ids_by_name[domain.name] = domain.id
        Promise.resolve data

    @reload_domains()

    @reload_entry_types = ->
      vm.entry_types_by_value = {}
      vm.entry_type_name_by_id = {}
      vm.log_entry_types = maibackend.LogEntryType.query({apikey: apikey})
      vm.log_entry_types.$promise.then (data) ->
        for entry_type in data
          vm.entry_types_by_value[entry_type.value] = entry_type
          vm.log_entry_type_id_by_name[entry_type.value] = entry_type.id
          vm.entry_type_name_by_id[entry_type.id] = entry_type.value
        Promise.resolve data
    @reload_entry_types()

    @update_log_entries = () ->
      vm.log_entries = maibackend.LogEntry.query({apikey: apikey})
      vm.log_entries.$promise.then (data) ->
        vm.latest_entry_by_entry_type = {}
        data = data.reverse()
        for d in data
          if not vm.latest_entry_by_entry_type[d.log_entry_type_id]
            vm.latest_entry_by_entry_type[d.log_entry_type_id] = d
        Promise.resolve data
        vm.mostrecententry = data[0]
    @update_log_entries()

    @users = maibackend.User.query({apikey: apikey})
    @users.$promise.then (data) ->
      for u in data
        vm.users_by_id[u.user_id] = u
      Promise.resolve data

    @add_log_entry = (value, log_entry_type) ->
      newEntry = new maibackend.LogEntry
      args = {value: value, apikey: apikey}
      if log_entry_type
        entryType = false
        for t in @log_entry_types
          if t.value == log_entry_type
            entryType = t
        if entryType
          args['log_entry_type_id'] = entryType.id
      newEntry.$save(args)
        .then () =>
          vm.update_log_entries()
      true
    @field_values = {}

    @get_dynamic_class = =>
      colors = {}
      colors[@color] = "true"
      colors[@intensity] = "true"
      return colors

    @comment_classes = {
    }

    @ggcolor = "pink"

    @dropdown_changed = () =>
      @comment_classes = {}
      @comment_classes[ @ggintensity ] = true
      @comment_classes[ @ggcolor ] = true

      console.log "dropdown_changed #{ @dropdown_value }"

    @ggcolors = [
      "yellow", "orange", "red", "purple", "blue", "green", "white", "black", "grey", "pink", "cyan", "brown"
    ]

    @ggintensity = "lighten-3"

    @dropdownintensity_changed = () =>
      console.log "dropdownintensity_changed #{ @dropdownintensity_value }"

    @ggintensity = [
      "lighten-5", "lighten-4", "lighten-3", "lighten-2", "lighten-1", "", "darken-1", "darken-2", "darken-3", "darken-4", "accent-1", "accent-2", "accent-3", "accent-4"
    ]

    @
}
