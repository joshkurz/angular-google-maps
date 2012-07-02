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
    .when "/map:params"
      templateUrl: "partials/map.html"
      controller: 'MapCtrl'
  	.otherwise 
  		redirectTo: "/"

  # $locationProvider.html5Mode true
 
app.run ($rootScope) ->
  rootScope = $rootScope
  rootScope.navBarHeight = 40

  # $('body')
  #   # .mouseup ->
  #   #   rootScope.mouseup = 1
  #   #   rootScope.mousedown = 0
  #   #   #rootScope.$apply()
  #   #   #console.log  'mouseup', rootScope.mouseup
  #   .mousedown ->
  #     rootScope.mousedown = 1
  #     rootScope.mouseup = 0
  #     #rootScope.$apply()
  #     #console.log  'mousedown', rootScope.mousedown
