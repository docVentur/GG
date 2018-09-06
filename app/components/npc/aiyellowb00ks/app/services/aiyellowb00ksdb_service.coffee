angular = require 'angular'
_ = require 'lodash'

app = angular.module 'ai.yellow.b00ks'

app.service 'aiyellowb00ksdb', (pouchDB, moment) ->
  @db = new PouchDB 'http://clu:5984/aiyellowb00ksdb'

  create_index = (db, index_name, emitter, doc_validity) ->
    ddoc = { _id: "_design/#{index_name}", views: { by_name: { map: "function (doc) {if (#{doc_validity}) {emit(#{ emitter });}}" }}}
    success = -> console.log "Created view: #{index_name}"
    failure = -> console.log "Probably ignorable failure to create view"
    db.put(ddoc).then success, failure

  #create_index @db, "tags",    "doc.name",    "doc.record_type == 'tag'"
  #create_index @db, "entries", "doc.comment", "doc.record_type == 'entry'"
  #create_index @db, "accounts", "doc.name", "doc.record_type == 'account'"
  #create_index @db, "account_entries", "doc.name", "doc.record_type == 'account_entry'"
  create_index @db, "entry_entered_at", "doc.timestamp, 1", "doc.timestamp"
  #create_index @db, "account_entry_entered_at", "doc.entered_at, 1", "doc.record_type == 'account_entry'"

  @create_entry = (type) ->
    @db.post
      session_id: "none"
      timestamp: moment().format()
      type: type

  @accounts = ->
    @db.query "accounts/by_name", {include_docs: true}

  @account_entries = ->
    @db.query "account_entries/by_name", {include_docs: true}

  @tags = ->
    @db.query "tags/by_name", {include_docs: true}

  @recent_entries = ->
    endkey = moment().subtract(1, 'hours').format()
    startkey = moment().add(1, 'hours').format()
    @db.query "entry_entered_at/by_name", {include_docs: true, descending: true, startkey: startkey, endkey: endkey}

  @less_recent_entries = ->
    endkey = moment().subtract(1, 'weeks').format()
    startkey = moment().add(1, 'weeks').format()
    @db.query "entry_entered_at/by_name", {include_docs: true, descending: true, startkey: startkey, endkey: endkey}

  @entries = ->
    entries = @db.query "entries/by_name", {include_docs: true}
    success = (data) -> console.log data
    failure = () -> console.log "it's dead"
    entries.then success, failure

    return entries

  @post = (options) ->
    @db.post options

  @put = (doc, options) ->
    @db.put doc, options

  @
