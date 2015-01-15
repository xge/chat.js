require('coffee-trace')
path        = require 'path'

bodyParser  = require 'body-parser'
clist       = require path.join(__dirname, 'clist')
config      = require '../config.json'
compression = require 'compression'
debug       = require('debug')(config.logger)
express     = require 'express'
Message     = require path.join(__dirname, 'message')
moment      = require 'moment'
morgan      = require 'morgan'

# bootstrap express
app = express()
app.use compression()
app.use bodyParser.json()
app.use morgan(config.logger)
app.use express.static(path.join(__dirname, '../build/app'))

# GET /
app.get '/', (req, res) ->
  res.sendfile path.join(__dirname, '../build/index.html')

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
  socket.emit 'msg', new Message(moment().valueOf(), 'System', "Welcome to #{ config.name }")

  socket.on 'msg', (msg) ->
    socket.broadcast.emit 'msg', new Message(msg.timestamp, msg.user, msg.payload)
