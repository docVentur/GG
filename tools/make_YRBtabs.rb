#!/usr/bin/env ruby
def get_coffee(vars)
  coffee_contents = <<HERE
angular = require 'angular'
_ = require 'lodash'

app = angular.module 'GG'

app.component 'aiTab#{vars[:camelname]}', {
  template: require('./#{vars[:hamlfilename]}'),
  controller: ($http) ->
    vm = @

    @
}
HERE

  return coffee_contents
end

def get_haml(vars)
  haml_contents = <<HERE
%h1 #{vars[:camelfilename]}
I am some text content on the #{vars[:camelfilename]} component

find me in #{vars[:hamlfilename]}
HERE
  return haml_contents
end

tabs = ['Y', 'O', 'R', 'P', 'B', 'G', 'W', 'L', 'E', 'I', 'C', 'N']

tabs.each_with_index do |letter, index|
  base = "#{index + 1}.#{letter}"
  vars = Hash.new
  vars[:camelname] = letter
  vars[:hamlfilename] = "#{base}.html.hamlc"
  vars[:coffeefilename] = "#{base}.coffee"
  File.open(vars[:coffeefilename], 'w') { |file| file.write(get_coffee(vars)) }
  File.open(vars[:hamlfilename], 'w') { |file| file.write(get_haml(vars)) }
end
