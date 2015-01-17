Clist = require '../lib/clist'

describe 'Clist', () ->

  clist = {}

  beforeEach () ->
    clist = new Clist()

  it 'should have a default value for randomNames', () ->
    clist.getRandomUsernamesAsList().length.should.be.above 0
    clist = new Clist ['Alice']
    clist.getRandomUsernamesAsList().should.have.length 1

  it 'should return the first available random username', () ->
    clist.addUser 'Alice'
    clist.addRandomUser().should.be.a.String
    clist.getUsernames().should.have.length 2

  it 'should add \'User\' if there are no more random usernames left', () ->
    for username in clist.getRandomUsernamesAsList()
      clist.addRandomUser()

    clist.addRandomUser().should.eql 'User'

  it 'should not add duplicates', () ->
    clist.addUser 'Alice'
    clist.addUser 'Alice'
    clist.getUsernames().should.eql ['Alice']

  it 'should remove a user', () ->
    clist.addUser 'Alice'
    clist.addUser 'Bob'
    clist.removeUser 'Bob'
    clist.getUsernames().should.eql ['Alice']
