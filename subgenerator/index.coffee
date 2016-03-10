require 'coffee-errors'

_      = require 'lodash'
util   = require 'util'
yeoman = require 'yeoman-generator'

class SubGeneratorGenerator extends yeoman.Base
  constructor: ->
    super

    @argument 'name', { type: String, required: true }

    unless @name?
      @log.error 'You have to provide a name for the subgenerator.'
      process.exit 1

    @className = _.upperFirst(_.camelCase(@name))

  templates: ->
    dirname = _.kebabCase @name

    @copy 'index.js', "#{dirname}/index.js"
    @copy 'index.coffee', "#{dirname}/index.coffee"
    @copy 'templates/somefile.coffee', "#{dirname}/templates/somefile.coffee"
    @template 'test/subgenerator.spec.coffee', "test/#{@name}.spec.coffee"

module.exports = SubGeneratorGenerator
