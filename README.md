# AngularJS Google Maps Example Application 

## Overview

The purpose of this project is to encourage collaboration from the community with how best to work with Google Maps using AngularJS. I started a [thread](https://groups.google.com/forum/?fromgroups&nomobile=true#!topic/angular/CM8ewcWeTF4) in AngularJS Google Groups.

## Technologies

The following technologies are being used for convenient, however, the fundamental code involving Google Maps and AngularJS can be leveraged on other projects.

- node.js
- express.js
- angularjs
- google maps api
- twitter bootstrap

## Current Status

This code running on a dev server at: [angular-google-maps.nodester.com/](angular-google-maps.nodester.com/)

## Initial Objective

Switch views between

- Home Splash (HOME) /
- Google Map (GMAP) /map
- Other pages

Initial load of site default to HOME. 

- Do not load unnecessary js such as from Google Map.

On first visit to GMAP view

- Determine if map div has already been initialized
- If not, initialize the map object
- Switch to GMAP

Realtime Updates To Map

- Using socket.io, maintain updates to GMAP
- Create a simple button to drop markers. Other users connected should see their markers appear on their map.