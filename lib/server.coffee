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
morgan      = require 'morgan'

# bootstrap express
app = express()
app.use compression()
app.use bodyParser.json()
app.use morgan(config.logger)
app.use express.static(path.join(__dirname, '../build/app'))

clist = new Clist ['Alice', 'Bob', 'Charlene', 'Denzel', 'Edgar', 'Fausto', 'Gary', 'Harriet', 'Ingo', 'Jockel', 'Kid']

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

  updateClist = () ->
    socket.emit 'clist changed', clist.getUsernames()
    socket.broadcast.emit 'clist changed', clist.getUsernames()

  socket.emit 'msg', new Message(moment().valueOf(), 'System', "Welcome to #{ config.name }")

  username = clist.addRandomUser()
  socket.emit 'new username', username
  updateClist()

  socket.on 'disconnect', () ->
    clist.removeUser username
    updateClist()

  socket.on 'msg', (msg) ->
    toSend = new Message(msg.timestamp, msg.user, msg.payload)
    socket.emit 'msg', toSend
    socket.broadcast.emit 'msg', toSend
