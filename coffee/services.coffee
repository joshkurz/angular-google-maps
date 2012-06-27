"use strict"

curCenter = null

initialize = (map_id, lat, lng, zoom) ->
  myOptions =
    zoom: zoom
    center: new google.maps.LatLng(lat, lng)
    mapTypeId: google.maps.MapTypeId.ROADMAP

  map = new google.maps.Map($(map_id)[0], myOptions)

  google.maps.event.addListener map, 'zoom_changed', ->
    console.log 'event'

  # $(window).resize(->
  #   map.setCenter(curCenter)
  #   #console.log 'reCenter ' + map.getCenter()
  # ).resize()

app = angular.module("ofm.services", [])

app.factory "GoogleMaps", ->
  map_id = "#map"

  lat = 9.984336
  lng = -84.168733
  zoom = 17
  map = initialize(map_id, lat, lng, zoom)
  # curCenter = new google.maps.LatLng(lat, lng)

  # google.maps.event.addListener window.map, 'center_changed', @onMapCenterChanged

  map
