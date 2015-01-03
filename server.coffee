require('coffee-trace')


bodyParser  = require "body-parser"
config      = require "./config.json"
debug       = require("debug")("logger")
express     = require "express"
morgan      = require "morgan"
path        = require "path"

# bootstrap express
app = express()
app.use bodyParser.json()
app.use morgan('dev')
app.use express.static(path.join(__dirname, "build/app"))
app.get "/", (req, res) ->
  res.sendfile "#{__dirname}/build/index.html"

# bootstrap socket.io
server      = require("http").Server(app)
io          = require("socket.io")(server)

server.listen config.port, () ->
  address = server.address()
  debug "Chat.js backend listening at http://%s:%s", address.address, address.port

io.on "connection", (socket) ->
  socket.emit "news", { hello: "world" }
  socket.on "my other event", (data) ->
    debug data

module.exports = app
