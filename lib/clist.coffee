module.exports = class Clist
  constructor: () ->
    @list = ['Alice']
  getNewUserName: () ->
    randomNames = [
        'Alice',
        'Bob',
        'Claire',
        'Denzel'
    ]
    for name in randomNames
      return name if not (name in @list)
