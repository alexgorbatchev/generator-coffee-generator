require 'coffee-errors'

util = require 'util'
yeoman = require 'yeoman-generator'

class SubGeneratorGenerator extends yeoman.generators.NamedBase
  constructor: ->
    super

    unless @name?
      @log.error 'You have to provide a name for the subgenerator.'
      process.exit 1

    @generatorName = @name
    @dirname = @_.dasherize @name

  templates: ->
    # have Yeoman greet the user.
    console.log @yeoman

    dir = @generatorName

    @copy 'index.js', "#{dir}/index.js"
    @copy 'index.coffee', "#{dir}/index.coffee"
    @copy 'templates/somefile.coffee', "#{dir}/templates/somefile.coffee"
    @template 'test/subgenerator.spec.coffee', "test/#{@generatorName}.spec.coffee"

module.exports = SubGeneratorGenerator
