// i converted from coffee back to js. Needs cleaning up.

var app, express, routes;
express = require("express");
routes = require("./routes");
app = module.exports = express.createServer();

app.configure(function() {
  app.set("port", process.env.PORT || 19058);
  app.set("views", __dirname + "/views");
  app.set("view engine", "jade");
  app.set("view options", {
    layout: false
  });
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(express.static(__dirname + "/public"));
  return app.use(app.router);
});

app.configure("development", function() {
  app.set("port", process.env.PORT || 3000);
  return app.use(express.errorHandler({
    dumpExceptions: true,
    showStack: true
  }));
});

app.configure("production", function() {
  return app.use(express.errorHandler());
});

app.get("/", routes.index);
app.get("/partials/:name", routes.partials);
app.get("*", routes.index);
app.listen(app.settings.port, function() {
  return console.log("Express server listening on port %d in %s mode", app.settings.port, app.settings.env);
});