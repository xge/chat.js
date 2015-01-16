Clist = require '../lib/clist'

describe 'Clist', () ->

  clist = {}

  beforeEach () ->
    clist = new Clist ['Alice', 'Bob']

  it 'should return a username', () ->
    clist.addRandomUser().should.eql 'Alice'
    clist.getUsernames().should.eql ['Alice']

  it 'should return the first available random username', () ->
    clist.addUser 'Alice'
    clist.addRandomUser().should.eql 'Bob'
    clist.getUsernames().should.eql ['Alice', 'Bob']

  it 'should not add duplicates', () ->
    clist.addUser 'Alice'
    clist.addUser 'Alice'
    clist.getUsernames().should.eql ['Alice']

  it 'should remove a user', () ->
    clist.addUser 'Alice'
    clist.addUser 'Bob'
    clist.removeUser 'Bob'
    clist.getUsernames().should.eql ['Alice']
