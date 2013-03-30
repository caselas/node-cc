# Require Node Modules
express = require 'express'
http    = require 'http'
jade    = require 'jade'
stylus  = require 'stylus'
nib     = require 'nib'

# Create New Application
app    = module.exports = express()
server = http.createServer(app)

# Configure Express App
app.configure ->
  app.set 'port', process.env.PORT || 5000
  app.set 'view engine', 'jade'
  app.set 'view options',
    layout: false
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use stylus.middleware
    src: __dirname + '/public'
    compile: (str, path) ->
      stylus(str)
      .set('filename', path)
      .set('compress', true)
      .use(nib())
  app.use express.static(__dirname + '/public')

# Socket.io config
io = require('socket.io').listen(server)
io.configure ->
  io.set "transports", ["xhr-polling"]
  io.set "polling duration", 10

# Define HTTP Routes
app.get "/", (request, response) ->
  response.render 'index'

# Listen for Connections
server.listen app.settings.port, ->
  console.log "Listening on " + app.settings.port

# Hello Socket.io
io.sockets.on 'connection', (socket) ->
  socket.emit 'news', { hello: 'world' }
  socket.on 'my other event', (data) ->
    console.log data
