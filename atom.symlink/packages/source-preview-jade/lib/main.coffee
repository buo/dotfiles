JadeProvider = require './jade-provider'

module.exports =

  activate: ->
    @provider = new JadeProvider

  deactivate: ->
    @provider = null

  provide: ->
    @provider
