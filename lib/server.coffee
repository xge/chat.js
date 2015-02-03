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
  res.sendFile path.join(__dirname, '../build/index.html')

# GET /config
app.get '/config', (req, res) ->
  res.sendFile path.join(__dirname, 'config.json')

# bootstrap socket.io
server      = require('http').Server(app)
io          = require('socket.io')(server)

server.listen config.port, () ->
  address = server.address()
  debug '[%s] %s listening at http://%s:%s', moment().format('HH:mm:ss'), config.name, address.address, address.port

io.on 'connection', (socket) ->
  ANNOUNCER = 'Announcer'
  username = clist.addRandomUser()
  debug '[%s] %s joined', moment().format('HH:mm:ss'), username

  # Transmit a message to all connected clients.
  all = (msg, event = 'msg') ->
    socket.emit event, msg
    socket.broadcast.emit event, msg

  updateClist = () ->
    all clist.getUsernames(), 'clist changed'

  socket.emit 'new username', username
  all new Message(null, ANNOUNCER, username), 'announce:join'
  updateClist()

  socket.on 'disconnect', () ->
    clist.removeUser username
    updateClist()
    all new Message(null, ANNOUNCER, username), 'announce:leave'
    debug '[%s] %s left', moment().format('HH:mm:ss'), username

  socket.on 'msg', (msg) ->
    msg = new Message(null, msg.user, msg.payload)
    all msg
    debug '[%s] %s: %s', moment(msg.timestamp).format('HH:mm:ss'), msg.user, msg.payload
