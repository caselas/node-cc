// Generated by CoffeeScript 1.6.2
(function() {
  var app, express, http, jade, nib, server, stylus;

  express = require('express');

  http = require('http');

  jade = require('jade');

  stylus = require('stylus');

  nib = require('nib');

  app = module.exports = express();

  server = http.createServer(app);

  app.configure(function() {
    app.set('port', process.env.PORT || 5000);
    app.set('view engine', 'jade');
    app.set('view options', {
      layout: false
    });
    app.use(express.bodyParser());
    app.use(express.methodOverride());
    app.use(stylus.middleware({
      src: __dirname + '/public',
      compile: function(str, path) {
        return stylus(str).set('filename', path).set('compress', true).use(nib());
      }
    }));
    return app.use(express["static"](__dirname + '/public'));
  });

  app.get("/", function(request, response) {
    return response.render('index');
  });

  server.listen(app.settings.port, function() {
    return console.log("Listening on " + app.settings.port);
  });

}).call(this);
