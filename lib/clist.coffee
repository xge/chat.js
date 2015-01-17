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
  addRandomUser: () ->
    username = @randomNames[Math.floor(Math.random() * @randomNames.length)] || 'User'
    @addUser username
    @randomNames = @randomNames.filter (name) -> name isnt username
    username
  removeUser: (username) ->
    @list = @list.filter (name) -> name isnt username
  getRandomUsernamesAsList: () ->
    @randomNames
  getUsernames: () ->
    @list
