require('coffee-trace')

bodyParser  = require "body-parser"
config      = require "./config.json"
express     = require "express"
debug       = require("debug")("logger")
morgan      = require "morgan"
path        = require "path"

# bootstrap express
app = express()
app.use bodyParser.json()
app.use morgan('dev')
app.use express.static(path.join(__dirname, "build/app"))

app.get "/", (req, res) ->
  res.sendfile "#{__dirname}/build/index.html"

server = app.listen config.port, () ->
  address = server.address()
  debug "Chat.js backend listening at http://%s:%s", address.address, address.port

module.exports = app
