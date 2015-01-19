require('coffee-trace')
path        = require 'path'

bodyParser  = require 'body-parser'
Clist       = require path.join(__dirname, 'clist')
config      = require '../config.json'
compression = require 'compression'
debug       = require('debug')(config.logger)
express     = require 'express'
Message     = require path.join(__dirname, 'message')
moment      = require 'moment'

# bootstrap express
app = express()
app.use compression()
app.use bodyParser.json()
app.use express.static(path.join(__dirname, '../build/app'))

clist = new Clist()

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
  debug '[%s] %s listening at http://%s:%s', moment().format('HH:mm:ss'), config.name, address.address, address.port

io.on 'connection', (socket) ->
  username = clist.addRandomUser()
  debug '[%s] %s joined', moment().format('HH:mm:ss'), username

  updateClist = () ->
    socket.emit 'clist changed', clist.getUsernames()
    socket.broadcast.emit 'clist changed', clist.getUsernames()

  socket.emit 'msg', new Message(moment().valueOf(), 'System', "Hello #{ username } and welcome to #{ config.name }")

  socket.emit 'new username', username
  updateClist()

  socket.on 'disconnect', () ->
    clist.removeUser username
    updateClist()
    debug '[%s] %s left', moment().format('HH:mm:ss'), username

  socket.on 'msg', (msg) ->
    toSend = new Message(msg.timestamp, msg.user, msg.payload)
    socket.emit 'msg', toSend
    socket.broadcast.emit 'msg', toSend
    debug '[%s] %s: %s', moment().format('HH:mm:ss'), msg.user, msg.payload
