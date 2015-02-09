require('coffee-trace')
path        = require 'path'

bodyParser  = require 'body-parser'
Clist       = require path.join(__dirname, 'clist')
Parser      = require path.join(__dirname, 'Parser')
config      = require '../config.json'
CONST       = require path.join(__dirname, 'constants')
compression = require 'compression'
debug       = require('debug')(config.logger)
express     = require 'express'
Message     = require path.join(__dirname, 'message')
moment      = require 'moment'

# constants
DATE_FORMAT = CONST.DATE_FORMAT
EVENTS = CONST.EVENTS

# bootstrap express
app = express()
app.use compression()
app.use bodyParser.json()
app.use express.static(path.join(__dirname, '../build/app'))

clist = new Clist()
parser = new Parser();

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
  debug '[%s] %s listening at http://%s:%s', moment().format(DATE_FORMAT), config.name, address.address, address.port

io.on EVENTS.CONNECT, (socket) ->
  username = clist.addRandomUser()
  debug '[%s] %s joined', moment().format(DATE_FORMAT), username

  # Transmit a message to all connected clients.
  all = (msg, event = EVENTS.MESSAGE) ->
    socket.emit event, msg
    socket.broadcast.emit event, msg

  updateClist = () ->
    all clist.getUsernames(), EVENTS.CLIST_UPDATE

  # ANNOUNCER sends the supplied event to everyone
  announce = (event) ->
    all new Message(null, CONST.ANNOUNCER, username), event

  socket.emit EVENTS.USER_NEW, username
  announce EVENTS.ANNOUNCE_JOIN
  updateClist()

  socket.on EVENTS.DISCONNECT, () ->
    clist.removeUser username
    updateClist()
    announce EVENTS.ANNOUNCE_LEAVE
    debug '[%s] %s left', moment().format(DATE_FORMAT), username

  socket.on EVENTS.MESSAGE, (msg) ->
    cmd = parser.parse(msg)
    switch cmd.action
      when 'help'
        helpMessages = [
          '/help for this helpscreen'
          '/name $new to rename to $new (if it\'s not already taken)'
        ]
        for helpMessage in helpMessages
          socket.emit EVENTS.MESSAGE, new Message(null, CONST.ANNOUNCER, helpMessage)
        break
      when 'name'
        tokens = msg.payload.match(/\w+|"[^"]+"/g)
        newUsername = tokens[1]
        if /\s/g.test(newUsername)
          newUsername = newUsername.slice(0, -1).slice(1)
        username = clist.rename(username, newUsername)
        socket.emit EVENTS.USER_NEW, username
        updateClist()
        break
      else
        all cmd.msg
        debug '[%s] %s: %s', moment(msg.timestamp).format(DATE_FORMAT), cmd.msg.user, cmd.msg.payload
