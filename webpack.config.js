'use strict';

var webpack = require('webpack');
var cleanPlugin = require('clean-webpack-plugin');
var ngInjectorPlugin = require('webpack-angular-injector-plugin');
const path = require('path');

var module_loaders = [
  { test: /\.coffee$/, loader: "coffee-loader" },
  { test: /\.html$/, loader: 'raw-loader', exclude: /node_modules/ },
  { test: /\.html\.hamlc$/, loader: "haml-loader" },
  { test: /\.(woff|woff2)(\?v=\d+\.\d+\.\d+)?$/, loader: 'url-loader?limit=10000&mimetype=application/font-woff'},
  { test: /\.ttf(\?v=\d+\.\d+\.\d+)?$/, loader: 'url-loader?limit=10000&mimetype=application/octet-stream'},
  { test: /\.jpg(\?v=\d+\.\d+\.\d+)?$/, loaders: ['url-loader', 'img-loader']},
  { test: /\.eot(\?v=\d+\.\d+\.\d+)?$/, loader: 'file-loader'},
  { test: /\.svg(\?v=\d+\.\d+\.\d+)?$/, loader: 'url-loader?limit=10000&mimetype=image/svg+xml'},
  { test: /\.css$/, loaders: ["style-loader","css-loader"] }
];

var config = module.exports = {
	context: __dirname,
	entry: {
    bundle: [ './app/index.coffee', 'webpack-material-design-icons']
  },
	module: {
    loaders: module_loaders,
    }
};

// this tells Webpack where to put its output, which will
// be a compiled JavaScript file

config.output = { filename: './dist/[name].js' }

config.resolve = {
        alias: {
          'npm': __dirname + '/node_modules'
        }
    }

config.devtool = '#cheap-module-eval-source-map'

config.plugins = [
  new cleanPlugin(['dist']),
  new ngInjectorPlugin({exclude: /node_modules/}),
  new webpack.ProvidePlugin({$: 'jquery', jQuery: 'jquery', "window.jQuery": "jquery"}),
//  new webpack.optimize.UglifyJsPlugin({
//      compress: {
//  	warnings: false
//      }
//  })
];
