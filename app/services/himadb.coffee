angular = require 'angular'
_ = require 'lodash'

app = angular.module 'gg'

app.service 'himadb', (pouchDB) ->
  #@db = new pouchDB 'himadb'
  @db = new pouchDB 'http://clu:5984/himadb'

#  create_index = (db, index_name, doc_validity) ->
#    ddoc = { _id: "_design/#{index_name}", views: { by_name: { map: "function (doc) {if (#{doc_validity}) {emit(doc.name);}}" }}}
#    db.put(ddoc).then -> console.log "Created view: #{index_name}"
#
#  create_index @db, "characters", "doc.record_type == 'character'"
#  create_index @db, "sections", "doc.record_type == 'section'"
#  create_index @db, "goals", "doc.record_type == 'goal'"
#
#  @characters = (callback) ->
#    @db.query "characters/by_name", {include_docs: true}
#
#  @sections = ->
#    @db.query "sections/by_name", {include_docs: true}
#
#  @goals = ->
#    @db.query "goals/by_name", {include_docs: true}

# "The voyage of discovery is not in seeking new landscapes but in having new eyes." -Marcel Proust via #::AGD
#
# "We are in a position something like the ancient alchemists. In the time before Mendeleev discovered the periodic table, showing how all the fundamental elements were interrelated, alchemists relied on a patchwork quilt of rules of thumb about how different chemicals could combine. These were necessarily incomplete, sometimes incorrect, and often semimystical, but by using these rules, the alchemists were able to accomplish surpring things, and their pursuit of the truth eventually led to modern chemistry." -Jesse Schell #::AGD

  @post = (options) =>
    @db.post options

  @put = (doc, options) =>
    @db.put doc, options

  @
