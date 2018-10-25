angular = require 'angular'
_ = require 'lodash'

app = angular.module 'gg'

app.service 'maibackend', ($resource) ->
  vm = @
  prefix = "http://rinzler:3000"
  prefix = "https://ai.gdkp.org"

  vm.jeanie_apikey = "3de34105fd2c6ded25181fef5bcc12ab"
  vm.mel_apikey = "bb43f6ba-8b77-4304-8d24-52db1319eb20"

  vm.Domain = $resource("#{prefix}/domains", {id: '@id'})
  vm.LogEntryType = $resource("#{prefix}/log_entry_types", {id: '@id'})
  vm.LogEntry = $resource("#{prefix}/log_entries", {id: '@id'})
  vm.User = $resource("#{prefix}/users", {id: '@id'})

  @
