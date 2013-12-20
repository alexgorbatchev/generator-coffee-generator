util = require 'util'
yeoman = require 'yeoman-generator'

class <%= _.classify(generatorName) %>Generator extends yeoman.generators.NamedBase
  constructor: (args, options, config) ->
    console.log "You called the <%= generatorName %> subgenerator with the argument #{@name}."

  files: ->
    @copy 'somefile.coffee', 'somefile.coffee'

module.exports = <%= _.classify(generatorName) %>Generator
