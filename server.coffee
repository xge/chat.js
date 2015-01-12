require('coffee-trace')


bodyParser  = require 'body-parser'
config      = require './config.json'
compression = require 'compression'
debug       = require('debug')(config.logger)
express     = require 'express'
moment      = require 'moment'
morgan      = require 'morgan'
path        = require 'path'

# bootstrap express
app = express()
app.use compression()
app.use bodyParser.json()
app.use morgan(config.logger)
app.use express.static(path.join(__dirname, 'build/app'))

# GET /
app.get '/', (req, res) ->
  res.sendfile "#{__dirname}/build/index.html"

# GET /config
app.get '/config', (req, res) ->
  res.sendfile 'config.json'

# bootstrap socket.io
server      = require('http').Server(app)
io          = require('socket.io')(server)

server.listen config.port, () ->
  address = server.address()
  debug '%s listening at http://%s:%s', config.name, address.address, address.port

io.on 'connection', (socket) ->
  socket.emit 'msg',
    timestamp: moment().valueOf()
    user: 'System'
    payload: "Welcome to #{ config.name }"

  socket.on 'msg', (msg) ->
    socket.broadcast.emit 'msg',
      timestamp: msg.timestamp
      user: msg.user
      payload: msg.payload

module.exports = app
