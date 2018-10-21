angular = require 'angular'
_ = require 'lodash'

app = angular.module 'gg'

app.component 'shipoopi', {
  template: require('./shipoopi.html.hamlc'),
  controller: (ailogdb, $resource, $http) ->
    vm = @

    $http.defaults.headers.post["Content-Type"] = "text/plain"

    apikey = "3de34105fd2c6ded25181fef5bcc12ab" # jeanie
    apikey = "bb43f6ba-8b77-4304-8d24-52db1319eb20" # mel

    prefix = "http://rinzler:3000"
    prefix = "http://ai.gdkp.org:4000"

    Domain = $resource("#{prefix}/domains", {id: '@id'})
    LogEntryType = $resource("#{prefix}/log_entry_types", {id: '@id'})
    LogEntry = $resource("#{prefix}/log_entries", {id: '@id'})
    User = $resource("#{prefix}/users", {id: '@id'})

    @users_by_id = {}
    @domain_ids_by_name = {}
    @entry_type_ids_by_name = {}
    @most_recent_by_type = {}
    @log_entry_type_id_by_name = {}
    @log_entries = []
    @domains = []
    @log_entry_types = []

    @reload_domains = ->
      vm.domains = Domain.query({apikey: apikey})
      vm.domains.$promise.then (data) ->
        for domain in data
          vm.domain_ids_by_name[domain.name] = domain.id
        Promise.resolve data

    @reload_domains()

    @domains.$promise.then (data) ->
      vm.require_domain 'Medication'
      Promise.resolve data

    @reload_entry_types = ->
      vm.entry_types_by_value = {}
      vm.log_entry_types = LogEntryType.query({apikey: apikey})
      vm.log_entry_types.$promise.then (data) ->
        for entry_type in data
          vm.entry_types_by_value[entry_type.value] = entry_type
          vm.log_entry_type_id_by_name[entry_type.value] = entry_type.id
        Promise.resolve data

    @reload_entry_types()
      .then () ->
        vm.require_log_entry_type 'Medication', 'pyridostigmine'


    @require_domain = (domain_name) ->
      for domain in vm.domains
        if domain.name == domain_name
          return domain
      newEntry = new Domain
      newEntry.$save({name: domain_name, apikey: apikey})
        .then (data) ->
          vm.reload_domains()

    @require_log_entry_type = (domain_name, require_entry_type) ->
      for entry_type in vm.log_entry_types
        if entry_type.value == require_entry_type
          return entry_type
      newEntry = new LogEntryType
      newEntry.$save({value: require_entry_type, domain_id: vm.domain_ids_by_name[domain_name], apikey: apikey})
        .then (data) ->
          vm.reload_entry_types()

    @update_log_entries = () ->
      vm.log_entries = LogEntry.query({apikey: apikey})
      vm.log_entries.$promise.then (data) ->
        vm.latest_entry_by_entry_type = {}
        data = data.reverse()
        for d in data
          if not vm.latest_entry_by_entry_type[d.log_entry_type_id]
            vm.latest_entry_by_entry_type[d.log_entry_type_id] = d
        console.log "Here are your datas america"
        console.log data
        Promise.resolve data
        console.log vm.latest_entry_by_entry_type
  
    @update_log_entries()

    @users = User.query({apikey: apikey})
    @users.$promise.then (data) ->
      for u in data
        vm.users_by_id[u.user_id] = u
      Promise.resolve data

    @add_log_entry = (entry, log_entry_type) ->
      newEntry = new LogEntry
      args = {entry: entry, apikey: apikey}
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

    @
}
