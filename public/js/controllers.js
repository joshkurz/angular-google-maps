
function HomeCtrl($scope) {
  $('#map').hide()
  $('.container-fluid').show()
}

function MapCtrl($scope, GoogleMaps) {
  $scope.map = GoogleMaps;
  $('#map').show()
  $('.container-fluid').hide()
}

MapCtrl.$inject = ['$scope','GoogleMaps'];
