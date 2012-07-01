module = angular.module "myApp.services", []

class GMap
  constructor: (options) ->
    @rootScope = options.rootScope
    @navBarHeight = 40
    @win = $(window)
    @mapEl = $("#map")
    @mapTypes = {m: 'map', h: 'satelite'}
    @mapEl.hide()
    @currCenter = options.center
    # resize mapEl div when window is initialize
    @resizeMapEl()

    # resize mapEl div when window is resized
    @win.resize @resizeMapEl

    @map = new google.maps.Map(@mapEl[0], {
      zoom: options.zoom
      center: new google.maps.LatLng(options.center.lat, options.center.lng)
      mapTypeId: google.maps.MapTypeId.ROADMAP
    })

    addListener = google.maps.event.addListener
    addListener @map, 'center_changed', @onCenterChanged

    @rootScope.currCenter = @currCenter


    # Bind map changes to scope
    # -------------------------
    # google.maps.event.addListener @map, "zoom_changed", ->
    #   @rootScope.$apply -> MapData.zoom = newValue

    # google.maps.event.addListener @map, 'center_changed', ->
    #   @rootScope.$apply -> 
    #     map_center = @map.getCenter()
    #     center = {lat: map_center.lat(), lng: map_center.lng()}

  resizeMapEl: =>
    @mapEl.css('height', (@win.height() - @navBarHeight))

  onCenterChanged: =>
    center = @map.getCenter()
    @currCenter.lat = center.lat()
    @currCenter.lng = center.lng()
    $('#crosshairlat').html(@currCenter.lat)
    $('#crosshairlng').html(@currCenter.lng)
    # console.log 'change center', @currCenter
    # console.log '@rootScope.$$watchers[0].last', @rootScope.$$watchers[0].last







module.factory "GoogleMap", ($rootScope, $location) ->
  rootScope = $rootScope
  SJO = {lat: 9.993552791991132, lng: -84.20888416469096}
  initPosition = SJO
  initZoom = 16


  # setLocationFromData = (data) ->
  #   params = (key + "=" + val for key,val of data).join('&')
  #   window.location.href = $location.path() + "?" + params

  mapOptions = 
    rootScope: rootScope
    zoom: initZoom
    mapType: 'm'
    center:
      lat: initPosition.lat
      lng: initPosition.lng

  # Bind scope changes to map
  # -------------------------

  # rootScope.$watch (->MapData.zoom), (zoom, oldValue) ->
  #   #console.log 'new zoom is '+zoom
  #   # map.setZoom(value)
  #   # setLocationFromData(MapData)

  # rootScope.$watch (->MapData.lat), (lat, oldValue) ->
  #   #console.log 'new lat is '+lat
  #   # map.setLat(value)
  #   # setLocationFromData(MapData)

  # rootScope.$watch (->MapData.lng), (lng, oldValue) ->
  #   # map.setLng(value)
  #   # setLocationFromData(MapData)

  # # Bind map changes to scope
  # # -------------------------
  # google_maps_event.addListener gMap.map, "zoom_changed", ->
  #   rootScope.$apply -> MapData.zoom = newValue

  # google_maps_event.addListener gMap.map, 'center_changed', ->
  #   rootScope.$apply -> 
  #     map_center = gMap.map.getCenter()
  #     center = {lat: map_center.lat(), lng: map_center.lng()}
  #     MapData.center = center

  return new GMap(mapOptions)
