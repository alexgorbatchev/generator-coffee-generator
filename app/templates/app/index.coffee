util = require 'util'
path = require 'path'
yeoman = require 'yeoman-generator'

class <%= _.classify(generatorName) %>Generator extends yeoman.generators.Base
  constructor: (args, options, config) ->
    super
    @on 'end', => @installDependencies skipInstall: options['skip-install']
    @pkg = JSON.parse @readFileAsString path.join __dirname, '../package.json'

  askFor: ->
    done = @async()

    # have Yeoman greet the user.
    console.log @yeoman

    prompts = [
      type: 'confirm'
      name: 'someOption'
      message: 'Would you like to enable this option?'
      default: true
    ]

    @prompt prompts, (props) =>
      @someOption = props.someOption
      done()

  app: ->
    @mkdir 'app'
    @mkdir 'app/templates'
    @copy '_package.json', 'package.json'

module.exports = <%= _.classify(generatorName) %>Generator