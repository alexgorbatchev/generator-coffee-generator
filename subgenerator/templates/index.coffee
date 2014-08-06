util = require 'util'
yeoman = require 'yeoman-generator'

class <%= _.classify(name) %>Generator extends yeoman.generators.NamedBase
  constructor: (args, options, config) ->
    super

    unless @name?
      @log.error 'You have to provide a name for the subgenerator.'
      process.exit 1

    console.log "Generating `#{@name}` based on `<%= name %>`."

  files: ->
    # have Yeoman greet the user.
    console.log @yeoman

    dirname = @_.dasherize @name

    @copy 'somefile.coffee', "#{dirname}/somefile.coffee"

module.exports = <%= _.classify(name) %>Generator
