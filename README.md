# AngularJS Google Maps Example Application 



## Overview

The purpose of this project is to encourage collaboration from the community with how best to work with Google Maps using AngularJS.
Although I have been a developer since '82, I have moderate experience with JavaScript and am very new to AngularJS. I do however see advantages using this framework.
Please feel free to submit issues for discussion. I will try to implement suggestions ASAP.

## Technologies

The following technologies are being used for convenient, however, the fundamental code involving Google Maps and AngularJS can be leveraged on other projects.

- node.js
- angularjs
- google maps api
- coffee-script (see wc.bat for real-time compiling)
- twitter bootstrap

## Current Status

I have a project based on this code running on a dev server at: [m.ourfield.org](m.ourfield.org)

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