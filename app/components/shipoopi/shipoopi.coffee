angular = require 'angular'
_ = require 'lodash'

app = angular.module 'gg'

app.component 'shipoopi', {
  template: require('./shipoopi.html.hamlc'),
  controller: (ailogdb, $resource, $http) ->
    vm = @

    $http.defaults.headers.post["Content-Type"] = "text/plain"

    apikey = "bb43f6ba-8b77-4304-8d24-52db1319eb20"

    prefix="http://rinzler:3000"
    prefix="http://ai.gdkp.org:4000"

    Domain = $resource("#{prefix}/domains", {id: '@id'})
    LogEntryType = $resource("#{prefix}/log_entry_types", {id: '@id'})
    LogEntry = $resource("#{prefix}/log_entries", {id: '@id'})
    User = $resource("#{prefix}/users", {id: '@id'})

    @users_by_id = {}

    @domains = Domain.query({apikey: apikey})
    
    @log_entry_types = LogEntryType.query({apikey: apikey})

    @log_entries = LogEntry.query({apikey: apikey})

    @log_entries = []

    @update_log_entries = () ->
      vm.log_entries = LogEntry.query({apikey: apikey})
      vm.log_entries.$promise.then (data) ->
        data = data.reverse()
        Promise.resolve data
  
    @update_log_entries()

    @users = User.query({apikey: apikey})
    @users.$promise.then (data) ->
      for u in data
        vm.users_by_id[u.user_id] = u
      console.log "Users by id:"
      console.log vm.users_by_id
      Promise.resolve data

    @add_log_entry = (entry) ->
      newEntry = new LogEntry
      newEntry.$save({entry: entry, apikey: apikey})
        .then () =>
          vm.update_log_entries()
      true

    @
}
