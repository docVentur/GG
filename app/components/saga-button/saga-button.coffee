angular = require 'angular'
_ = require 'lodash'

app = angular.module 'gg'

app.component 'sagaButton', {
  template: require('./saga-button.html.hamlc'),
  bindings:
    icon: "@"
    name: "@"
    color: "@"
    mostrecententry: "<"
    type: "@"
    fields: "<"
    intensity: "@"
  controller: (ailogdb) ->
    vm = @
    @field_values = {}

    @entries = ailogdb.objects.entries
    @make_entry = =>
      new_doc = {name: @name, comment: "button press", type: @type, color: @color, icon: @icon}
      if @field_values
        new_doc['fields'] = @field_values
      if @intensity
        new_doc['intensity'] = @intensity
      doc = ailogdb.create_entry new_doc
      console.log "button pressed"
    @get_dynamic_class = =>
      colors = {}
      colors[@color] = "true"
      colors[@intensity] = "true"
      return colors
    @
}
