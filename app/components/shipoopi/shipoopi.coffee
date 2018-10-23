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
    prefix = "https://ai.gdkp.org"

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
      vm.require_domain 'Dailies'
      vm.require_domain 'Weeklies'
      vm.require_domain 'Fewd'
      vm.require_domain 'Color'
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
        vm.require_log_entry_type 'Medication', 'nebulizer'
        vm.require_log_entry_type 'Medication', 'albuterol inhaler'
        vm.require_log_entry_type 'Medication', 'Advair'
        vm.require_log_entry_type 'Medication', 'Pig Pill'
        vm.require_log_entry_type 'Medication', 'Pain Management'
        vm.require_log_entry_type 'Dailies', 'de-Hare the Shower'
        vm.require_log_entry_type 'Dailies', 'Clean Sink'
        vm.require_log_entry_type 'Dailies', 'Laundry Done'
        vm.require_log_entry_type 'Dailies', 'Took out the Trash'
        vm.require_log_entry_type 'Dailies', 'Brushed Teeth'
        vm.require_log_entry_type 'Weeklies', 'Cleaned the Rat Cage'
        vm.require_log_entry_type 'Weeklies', 'Recycling'
        vm.require_log_entry_type 'Weeklies', 'Post Office'
        vm.require_log_entry_type 'Weeklies', 'Mail Check'
        vm.require_log_entry_type 'Weeklies', 'Shopping Trip'
        vm.require_log_entry_type 'Fewd', 'Soda: 20oz Bottle'
        vm.require_log_entry_type 'Fewd', 'Soda: 12oz Can'
        vm.require_log_entry_type 'Fewd', 'Capital Tea'
        vm.require_log_entry_type 'Fewd', 'Steak'
        vm.require_log_entry_type 'Fewd', 'Taco Tuesday'
        vm.require_log_entry_type 'Fewd', 'Sheperds Pi'
        vm.require_log_entry_type 'Fewd', 'Chicken Thighs'
        vm.require_log_entry_type 'Fewd', 'Salman'
        vm.require_log_entry_type 'Fewd', 'Tamales'
        vm.require_log_entry_type 'Fewd', 'Yogurt'
        vm.require_log_entry_type 'Fewd', 'Tuna'
        vm.require_log_entry_type 'Fewd', 'Cereal'
        vm.require_log_entry_type 'Fewd', 'Quesadilla'
        vm.require_log_entry_type 'Fewd', 'Oatmeal'
        vm.require_log_entry_type 'Fewd', 'French Fries'
        vm.require_log_entry_type 'Fewd', 'Vegetables'
        vm.require_log_entry_type 'Fewd', 'Salad'
        vm.require_log_entry_type 'Color', 'yellow'
        vm.require_log_entry_type 'Color', 'orange'
        vm.require_log_entry_type 'Color', 'red'
        vm.require_log_entry_type 'Color', 'purple'
        vm.require_log_entry_type 'Color', 'blue'
        vm.require_log_entry_type 'Color', 'green'
        vm.require_log_entry_type 'Color', 'white'
        vm.require_log_entry_type 'Color', 'black'
        vm.require_log_entry_type 'Color', 'grey'
        vm.require_log_entry_type 'Color', 'pink'
        vm.require_log_entry_type 'Color', 'cyan'
        vm.require_log_entry_type 'Color', 'brown'                                                                        

        vm.reload_entry_types()


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
        vm.mostrecententry=data[0]

    @update_log_entries()

    @users = User.query({apikey: apikey})
    @users.$promise.then (data) ->
      for u in data
        vm.users_by_id[u.user_id] = u
      Promise.resolve data

    @add_log_entry = (entry, log_entry_type) ->
      newEntry = new LogEntry
      args = {entry: entry, apikey: apikey}
      console.log "add_log_entry()"
      if log_entry_type
        console.log "with log_entry_type"
        console.log log_entry_type
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
