angular = require 'angular'
_ = require 'lodash'

app = angular.module 'gg'

app.service 'ailogdb', (pouchDB, $rootScope, moment) ->
  @db = pouchDB 'http://clu:5984/ailogdb'
  @objects = {}
  @name_by_uri = {}

  @documentsForSchema = (schema) ->
    console.log "for schema #{schema}"
    @db.query "documentsBySchema/by_name", {include_docs: true, key: schema}

  @register_object = (uri, name) =>
    @objects[name] = []
    @name_by_uri[uri] = name

  @map_task = (items, make_req, map_promise, complete_promise) =>
    process_it = (item, result) =>
      map_promise item, result
      process_next()
    process_next = () =>
      item = items.pop()
      if item
        req = make_req item
        success = process_it.bind @, item
        fail = process_next
        req.then success, fail
      else
        complete_promise()
    process_next()

  @disposition_object_document = (doc) =>
    sort_keys = ['entered_at']
    if key = @name_by_uri[doc.$ref]
      array = @objects[key]
      index = _.findIndex array, (f) -> f._id == doc._id
      if index == -1
        array.push doc
      else
        array[index] = doc
    for sort_key in sort_keys
      if doc[sort_key]
        sorted = _.sortBy @objects[key], sort_key
        _.reverse sorted
        @objects[key].length = 0
        @objects[key].push.apply @objects[key], sorted

  load_initial_objects = () =>
    items = _.keys @name_by_uri
    make_request = (item) =>
      @documentsForSchema item
    process_response = (uri, response) =>
      _.map response.rows, (r) =>
        @disposition_object_document r.doc
    when_done = () =>
      on_change = (change) =>
        if change.deleted
          @when_done_callback() if @when_done_callback
        else
          @disposition_object_document change.doc
          @when_done_callback() if @when_done_callback
          $rootScope.$apply()
      @db.changes {since: 'now', include_docs: true, live: true}
        .on 'change', on_change
        .on 'error', (err) -> console.log "Err: #{err}"
      console.log "DONE DONE!"
      console.log @objects
      @when_done_callback() if @when_done_callback
    @map_task items, make_request, process_response, when_done

  @register_object "http://gg/ai.log/entry.schema", "entries"

  create_index = (db, index_name, emitter, doc_validity) ->
    ddoc = { _id: "_design/#{index_name}", views: { by_name: { map: "function (doc) {if (#{doc_validity}) {emit(#{ emitter });}}" }}}
    success = -> console.log "Created view: #{index_name}"
    failure = -> console.log "Probably ignorable failure to create view"
    db.put(ddoc).then success, failure

  create_index @db, "schemas", "doc.$id", "doc.$schema"
  create_index @db, "documentsBySchema", "doc.$ref", "doc.$ref"


  @post = (options) ->
    options = {} unless options
    @db.post options
  @put = (doc, options) ->
    options = {} unless options
    @db.put doc, options

  @create_entry = (doc) ->
    doc.$ref ="http://gg/ai.log/entry.schema"
    doc.entered_at = moment().format()
    console.log doc
    @db.post doc

  @when_done_callback = undefined

  @when_done = (callback) =>
    @when_done_callback = callback

  load_initial_objects()

  @recent_entries = ->
    endkey = moment().subtract(25, 'hours').format()
    startkey = moment().add(1, 'hours').format()
    @db.query "entry_entered_at/by_name", {include_docs: true, descending: true, startkey: startkey, endkey: endkey}




  @
