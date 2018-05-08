(function () {
  'use strict';

  angular.module('gg')
    .factory('d3',[function(){
      var d3;
    // https://d3js.org Version 4.13.0. Copyright 2018 Mike Bostock.
      d3 = require("./d3.v4.min.js")
      return d3;
    }]);

}());
