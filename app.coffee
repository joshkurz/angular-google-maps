express = require("express")
routes = require("./routes")
app = module.exports = express.createServer()

app.configure ->
  app.set "port", process.env.PORT or 19058
  app.set "views", __dirname + "/views"
  app.set "view engine", "jade"
  app.set "view options",
    layout: false

  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.static(__dirname + "/public")
  app.use app.router

app.configure "development", ->
  app.set "port", process.env.PORT or 3000
  app.use express.errorHandler(
    dumpExceptions: true
    showStack: true
  )

app.configure "production", ->
  app.use express.errorHandler()

app.get "/", routes.index
app.get "/partials/:name", routes.partials
app.get "*", routes.index
app.listen app.settings.port, ->
  console.log "Express server listening on port %d in %s mode", app.settings.port, app.settings.env