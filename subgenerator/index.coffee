require 'coffee-errors'

util = require 'util'
yeoman = require 'yeoman-generator'

class SubGeneratorGenerator extends yeoman.generators.NamedBase
  constructor: ->
    super

    unless @name?
      @log.error 'You have to provide a name for the subgenerator.'
      process.exit 1

  templates: ->
    # have Yeoman greet the user.
    console.log @yeoman

    dirname = @_.dasherize @name

    @copy 'index.js', "#{dirname}/index.js"
    @copy 'index.coffee', "#{dirname}/index.coffee"
    @copy 'templates/somefile.coffee', "#{dirname}/templates/somefile.coffee"
    @template 'test/subgenerator.spec.coffee', "test/#{@name}.spec.coffee"

module.exports = SubGeneratorGenerator
