module = angular.module "ofm.services", []

initializeGoogleMap = (options, $location) ->
  $window = $(window)
  $("#map").hide()

  $window.bind('resize', ->
    $("#map").css(
      height: ($window.height() - 45)+'px'
      width: $window.width()
      top: '45px'
    )
  )

  return new google.maps.Map(document.getElementById("map"), {
    zoom: options.zoom
    center: new google.maps.LatLng(options.lat, options.lng)
    mapTypeId: google.maps.MapTypeId.ROADMAP
  })


module.factory "GoogleMap", ($rootScope, $location) ->
  map = initializeGoogleMap(zoom: 10, lat: 10, lng: 10)

  # setLocationFromData = (data) ->
  #   params = (key + "=" + val for key,val of data).join('&')
  #   $location.path $location.path().substr(0,$location.path().indexOf('/')) + "?" + params

  MapData = 
    zoom: 10
    lat: 10
    lng: 10

  # Bind scope changes to map
  # -------------------------
  $rootScope.$watch (->MapData.zoom), (zoom, oldValue) ->
    # map.setZoom(value)
    # setLocationFromData(MapData)

  $rootScope.$watch (->MapData.lat), (lat, oldValue) ->
    console.log 'new lat is '+lat
    # map.setLat(value)
    # setLocationFromData(MapData)

  $rootScope.$watch (->MapData.lng), (lng, oldValue) ->
    # map.setLng(value)
    # setLocationFromData(MapData)

  # Bind map changes to scope
  # -------------------------
  google.maps.event.addListener(map, "zoom_changed", ->
    $rootScope.$apply -> MapData.zoom = newValue
  )

  return MapData
