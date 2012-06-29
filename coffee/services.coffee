"use strict"
app = undefined
curCenter = undefined
initialize = undefined
curCenter = null
initialize = (map_id, lat, lng, zoom) ->
  map = undefined
  myOptions = undefined
  myOptions =
    zoom: zoom
    center: new google.maps.LatLng(lat, lng)
    mapTypeId: google.maps.MapTypeId.ROADMAP

  map = new google.maps.Map($(map_id)[0], myOptions)
  google.maps.event.addListener map, "zoom_changed", ->
    console.log "event"

app = angular.module("ofm.services", [])
app.factory "GoogleMaps", ->
  lat = undefined
  lng = undefined
  map = undefined
  map_id = undefined
  zoom = undefined
  map_id = "#map"
  lat = 9.984336
  lng = -84.168733
  zoom = 17
  map = initialize(map_id, lat, lng, zoom)
  map