express = require("express")
app = module.exports = express.createServer()

app.configure ->
  app.set "port", process.env.PORT or 19058
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.static(__dirname + "/public")

app.configure "development", ->
  app.set "port", process.env.PORT or 3000
  app.use express.errorHandler(
    dumpExceptions: true
    showStack: true
  )

app.configure "production", ->
  app.use express.errorHandler()

app.listen app.settings.port, ->
  console.log "Express server listening on port %d in %s mode", app.settings.port, app.settings.env