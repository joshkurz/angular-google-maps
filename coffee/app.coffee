"use strict"
app = angular.module "myApp", [ "myApp.filters", "myApp.services", "myApp.directives", "myApp.controllers" ]

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
 