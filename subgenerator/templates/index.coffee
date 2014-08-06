util = require 'util'
yeoman = require 'yeoman-generator'

class <%= _.classify(generatorName) %>Generator extends yeoman.generators.NamedBase
  constructor: (args, options, config) ->
    console.log "Generating `#{@name}` based on `<%= generatorName %>`."

  files: ->
    @copy 'somefile.coffee', 'somefile.coffee'

module.exports = <%= _.classify(generatorName) %>Generator
