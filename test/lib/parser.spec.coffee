Parser = require '../../lib/Parser.coffee'
Message = require '../../lib/message.coffee'

describe 'Parser', () ->

  cmd = {}

  beforeEach () ->
    cmd = new Parser()

  it 'should return a proper object', () ->
    result = cmd.parse(new Message(null, null, null))
    result.action.should.be.a.String
    result.msg.should.be.a.Message

  it 'should parse a rename cmd', () ->
    result = cmd.parse(new Message(null, 'Yargo', '/name Denzel'))
    result.action.should.equal 'name'
    result.msg.user.should.equal 'Yargo'
    result.msg.payload.should.equal '/name Denzel'

  it 'should parse a help cmd', () ->
    result = cmd.parse(new Message(null, 'Yargo', '/help Denzel'))
    result.action.should.equal 'help'
    result.msg.payload.should.equal '/help Denzel'

  it 'should not parse an invalid cmd', () ->
    result = cmd.parse(new Message(null, 'Yargo', '/sudo Denzel'))
    result.action.should.equal 'msg'
    result.msg.payload.should.equal '/sudo Denzel'