Clist = require '../lib/clist'

describe 'Clist', () ->
  describe 'username generator', () ->
    it 'should return a username', () ->
      clist = new Clist()
      clist.getNewUserName().should.equal 'Bob'
