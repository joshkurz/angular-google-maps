#!/bin/bash

coffee -c --watch -o static/js scripts/coffee 
coffee -o static/js/ -c -w static/coffee/
coffee -wj static/js/app -c static/coffee/models/ static/coffee/collections/ static/coffee/views/ static/coffee/app
coffee -o public/js -wc coffee