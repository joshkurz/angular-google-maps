module = angular.module "myApp.services", []

class GMap
  constructor: (options) ->
    @rootScope = options.rootScope
    @center = options.center
    @zoom = options.zoom
    @mapType = options.mapType
    @navBarHeight = options.navBarHeight

    @win = $(window)
    @mapEl = $("#map")
    @mapTypes = {m: 'map', h: 'hybrid'}


    mapTypeControl: true
    mapTypeControlOptions: 
      style: google.maps.MapTypeControlStyle.HORIZONTAL_BAR,
      position: google.maps.ControlPosition.TOP_RIGHT
      mapTypeIds: [google.maps.MapTypeId.ROADMAP, google.maps.MapTypeId.HYBRID]

    panControl: false
    panControlOptions:
      position: google.maps.ControlPosition.TOP_RIGHT

    streetViewControl: false
    streetViewControlOptions:
      position: google.maps.ControlPosition.LEFT_TOP
  
    zoomControl: true
    zoomControlOptions:
      style: google.maps.ZoomControlStyle.LARGE
      position: google.maps.ControlPosition.LEFT_TOP


    @mapEl.hide()
    # resize mapEl div when window is initialize
    @resizeMapEl()

    # resize mapEl div when window is resized
    @win.resize @resizeMapEl

    @map = new google.maps.Map(@mapEl[0], {
      zoom: @zoom
      center: new google.maps.LatLng(options.center.lat, options.center.lng)
      mapTypeId: google.maps.MapTypeId.ROADMAP
    })

    addListener = google.maps.event.addListener
    addListener @map, 'center_changed', @onCenterChanged
    addListener @map, 'maptypeid_changed', @onTypeChange
    addListener @map, 'zoom_changed', @onZoomChange


    # TODO: set/update URL with params and user session
    # google.maps.event.addListener window.map, 'zoom_changed', =>
    #   @preferences.set('zoom', window.map.getZoom())


    @rootScope.mapCenter = @center
    @rootScope.mapZoom = @zoom
    @rootScope.mapType = @mapType

  resizeMapEl: =>
    @mapEl.css('height', (@win.height() - @navBarHeight))

  onCenterChanged: =>
    center = @map.getCenter()
    @center.lat = center.lat()
    @center.lng = center.lng()
    $('#crosshairlat').html(@center.lat)
    $('#crosshairlng').html(@center.lng)
    @rootScope.mapCenter = @center
    @rootScope.$apply()

  onZoomChange: =>
    @rootScope.mapZoom = @zoom = @map.getZoom()
    @rootScope.$apply()

  onTypeChange: =>
    @mapType = @map.getMapTypeId()
    
    #TODO LWE: add polyOpts
    switch @map.getMapTypeId()
      when google.maps.MapTypeId.ROADMAP, google.maps.MapTypeId.HYBRID
        @polyOpts = true # @roadmapPolyOpts
      else
        @polyOpts = true # @hybridPolyOpts
    
    @rootScope.mapType = @mapType[0]
    @rootScope.$apply()




module.factory "GoogleMap", ($rootScope, $location) ->
  rootScope = $rootScope
  SJO = {lat: 9.993552791991132, lng: -84.20888416469096}
  initPosition = SJO
  initZoom = 16


  # setLocationFromData = (data) ->
  #   params = (key + "=" + val for key,val of data).join('&')
  #   window.location.href = $location.path() + "?" + params

  mapOptions = 
    navBarHeight: 40 # This should be set on app scope on init
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
