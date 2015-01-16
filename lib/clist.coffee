module.exports = class Clist
  constructor: (@randomNames = ['Alice', 'Bob']) ->
    @list = []
  addUser: (username) ->
    if not (username in @list)
      @list.push username
  addRandomUser: () ->
    for name in @randomNames
      if not (name in @list)
        @list.push name
        return name
  removeUser: (username) ->
    @list = @list.filter (item) -> item isnt username
  getUsernames: () ->
    @list
