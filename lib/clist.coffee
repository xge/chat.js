module.exports = class Clist
  constructor: (@randomNames) ->
    if !@randomNames
      @randomNames = [
        'Alice'
        'Adelheid'
        'Bob'
        'Bert'
        'Bingolf'
        'Charlene'
        'Chicoree'
        'Denzel'
        'Dwen'
        'Edga'
        'Ensbert'
        'Fausto'
        'Ferdinand'
        'Franz'
        'Gary'
        'Grimm'
        'Harriet'
        'Hans'
        'Ingo'
        'Ito'
        'Jockel'
        'Jupp'
        'Kid'
        'Karl'
        'Lumbo'
        'Largo'
        'Madga'
        'Madam'
        'Nido'
        'Nardo'
        'Orwell'
        'Opera'
        'Peace'
        'Pons'
        'Quenn'
        'Quido'
        'Randel'
        'Rimbo'
        'Susi'
        'Simbald'
        'Tama'
        'Tango'
        'Urs'
        'Ursula'
        'Urt'
        'Vlodo'
        'Vandoo'
        'Walter'
        'Warso'
        'Wirsch'
        'Xeta'
        'Xanthal'
        'Yaw'
        'Yumm'
        'Zhar'
        'Zunder'
        'Zippy'
      ]
    @list = []
  addUser: (username) ->
    if not (username in @list)
      @list.push username
      username
  addRandomUser: () ->
    username = @randomNames[Math.floor(Math.random() * @randomNames.length)] || 'User'
    @randomNames = @randomNames.filter (name) -> name isnt username
    @addUser username
  removeUser: (username) ->
    @randomNames.push username if username isnt 'User'
    @list = @list.filter (name) -> name isnt username
  getRandomUsernamesAsList: () ->
    @randomNames
  getUsernames: () ->
    @list
