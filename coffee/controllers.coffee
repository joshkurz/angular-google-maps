root = exports ? this

root.HomeCtrl = ($scope) ->
  $("#map").hide()
  $(".container-fluid").show()

root.MapCtrl = ($scope, GoogleMaps) ->
  $scope.map = GoogleMaps
  $("#map").show()
  $(".container-fluid").hide()
  
root.MapCtrl.$inject = [ "$scope", "GoogleMaps" ]