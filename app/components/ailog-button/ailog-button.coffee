angular = require 'angular'
_ = require 'lodash'

app = angular.module 'gg'

app.component 'ailogButton', {
  template: require('./ailog-button.html.hamlc'),
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
      if @intensity
        new_doc['intensity'] = @intensity
      doc = ailogdb.create_entry new_doc
      console.log "button pressed"
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
      @comment_classes[ @intensity ] = true
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
