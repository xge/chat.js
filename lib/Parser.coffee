class Parser
  constructor: () ->
    @availableCommands = ['name', 'help']
  parse: (msg) ->
    if (msg?.payload?.charCodeAt(0) is 47)
      tokens = msg.payload.split ' '
      cmdName = tokens[0].slice 1
      if (cmdName in @availableCommands)
        return {
          action: cmdName
          msg: msg
        }

    return {
      action: 'msg'
      msg: msg
    }

exports = module.exports = Parser