module = angular.module "myApp.services", []

class GMap
  constructor: (options) ->
    # TODO: What is method to loop through option attribs and assign to @/this?
    @rootScope      = options.rootScope
    @dragging       = 0 # user id dragging map
    @location       = options.location

    # check for lat/lng, zoom, maptype on url
    q               = @location.search().q
    if q
      ll            = q.split(',')
      lat           = ll[0]
      lng           = ll[1]
      @center       = {lat:lat, lng:lng}
    else
      @center       = options.center
    

    @zoom           =  parseInt(@location.search().z) || options.zoom
    @mapType        =  @location.search().t || options.mapType

    @navBarHeight   = @rootScope.navBarHeight

    @win            = $(window)
    @crossHairLatEl = $('#mapcrosshairlat')
    @crossHairLngEl = $('#mapcrosshairlng')
    @mapEl          = $("#map")
    @mapTypes       = {m: 'roadmap', h: 'hybrid'}

    mapTypeControl: true
    mapTypeControlOptions: 
      style:        google.maps.MapTypeControlStyle.HORIZONTAL_BAR,
      position:     google.maps.ControlPosition.TOP_RIGHT
      mapTypeIds:   [google.maps.MapTypeId.ROADMAP, google.maps.MapTypeId.HYBRID]

    panControl:     false
    panControlOptions:
      position:     google.maps.ControlPosition.TOP_RIGHT

    streetViewControl:false
    streetViewControlOptions:
      position:     google.maps.ControlPosition.LEFT_TOP
  
    zoomControl: true
    zoomControlOptions:
      style:        google.maps.ZoomControlStyle.LARGE
      position:     google.maps.ControlPosition.LEFT_TOP

    @mapEl.hide()

    # resize mapEl div when window is initialize
    @resizeMapEl()

    # resize mapEl div when window is resized
    @win.resize @resizeMapEl

    @map            = new google.maps.Map(@mapEl[0], {
      zoom:         @zoom
      center:       new google.maps.LatLng(@center.lat, @center.lng)
      mapTypeId:    @mapTypes[@mapType]
    })

    addListener     = google.maps.event.addListener
    addListener @map, 'center_changed',     @onCenterChanged
    addListener @map, 'maptypeid_changed',  @onTypeChange
    addListener @map, 'zoom_changed',       @onZoomChange
    addListener @map, 'dragstart',          @onDragStart
    addListener @map, 'dragend',            @onDragEnd

    @rootScope.protocol   = @location.protocol()
    @rootScope.host       = @location.host()
    @rootScope.mapCenter  = @center
    @rootScope.mapZoom    = @zoom
    @rootScope.mapType    = @mapType

    @updateLocation()

  updateLocation: ->
    @location.url("/maps?q=#{@center.lat},#{@center.lng}&t=#{@mapType}&z=#{@zoom}")

  onDragStart: =>
    @dragging             = on

  onDragEnd: =>
    @dragging             = off
    @onCenterChanged()

  resizeMapEl: =>
    @mapEl.css('height',  (@win.height() - @navBarHeight))

  onCenterChanged: =>
    center                = @map.getCenter()
    @center.lat           = center.lat()
    @center.lng           = center.lng()
    @crossHairLatEl.html( @center.lat)
    @crossHairLngEl.html( @center.lng)

    if not @dragging
      @rootScope.mapCenter = @center
      @rootScope.$apply()

      @updateLocation()

  onZoomChange: =>
    @rootScope.mapZoom    = @zoom = @map.getZoom()
    @rootScope.$apply()
    @updateLocation()

  onTypeChange: =>
    @mapType = @map.getMapTypeId()

    #TODO LWE: add polyOpts
    switch @map.getMapTypeId()
      when google.maps.MapTypeId.ROADMAP, google.maps.MapTypeId.HYBRID
        @polyOpts         = true # @roadmapPolyOpts
      else
        @polyOpts         = true # @hybridPolyOpts
    
    @rootScope.mapType    = @mapType[0]
    @rootScope.$apply()
    @updateLocation()

module.factory "GoogleMap", ($rootScope, $location) ->
  SJO                     = {lat: 9.993552791991132, lng: -84.20888416469096}
  initPosition            = SJO
  initZoom                = 16

  mapOptions = 
    rootScope:            $rootScope
    location:             $location
    zoom:                 initZoom
    mapType:              'm'
    center:
      lat:                initPosition.lat
      lng:                initPosition.lng

  return new GMap(mapOptions)
