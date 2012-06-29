"use strict"
app = angular.module "ofm", [ "ofm.filters", "ofm.services", "ofm.directives", "ofm.controllers" ]

app.config ($routeProvider, $locationProvider) ->
  $routeProvider
  	.when "/",
    	templateUrl: "partials/home.html"
    	controller: 'HomeCtrl'
  	.when "/map"
    	templateUrl: "partials/map.html"
    	controller: 'MapCtrl'
  	.otherwise 
  		redirectTo: "/"
 