
module = angular.module("myApp.controllers", [])

module.controller "MainCtrl", ($scope, GoogleMap, $location) ->
	$scope.mapShown = ->
		return $location.path().indexOf('/map') > -1
        
    $scope.map = GoogleMap


module.controller "HomeCtrl", ($scope, GoogleMap) ->


module.controller "MapCtrl", ($scope) ->