# Require Node Modules
express = require "express"
jade    = require "jade"

# Create New Application
app = module.exports = express()

# Configure Express App
app.configure ->
  app.set 'port', process.env.PORT || 5000
  app.set 'view engine', 'jade'
  app.set "view options",
    layout: false
  app.use express.bodyParser()
  app.use express.methodOverride()

# Define HTTP Routes
app.get "/", (request, response) ->
  response.render 'index'

# Listen for Connections
app.listen app.settings.port, ->
  console.log "Listening on #{app.settings.port}"
