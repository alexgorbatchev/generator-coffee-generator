_      = require 'lodash'
util   = require 'util'
yeoman = require 'yeoman-generator'

class <%= className %>Generator extends yeoman.NamedBase
  constructor: (args, options, config) ->
    super

    unless @name?
      @log.error 'You have to provide a name for the subgenerator.'
      process.exit 1

    @className = _.upperFirst(_.camelCase(@name))

    console.log "Generating `#{@name}` based on `<%= name %>`."

  files: ->
    dirname = _.kebabCase @name

    @copy 'somefile.coffee', "#{dirname}/somefile.coffee"

module.exports = <%= className %>Generator
