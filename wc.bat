@echo off
REM "C:/Program Files (x86)/nodejs/node"  utils/coffee-script/bin/coffee -c --watch -o static/js scripts/coffee 
REM "C:/Program Files (x86)/nodejs/node"  utils/coffee-script/bin/coffee -o static/js/ -c -w static/coffee/
REM "C:/Program Files (x86)/nodejs/node"  utils/coffee-script/bin/coffee -wj static/js/app -c static/coffee/models/ static/coffee/collections/ static/coffee/views/ static/coffee/app

coffee -o public/js -wc coffee