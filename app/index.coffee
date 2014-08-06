require 'coffee-errors'

util = require 'util'
path = require 'path'
fs = require 'fs'
url = require 'url'
GitHubApi = require 'github'
yeoman = require 'yeoman-generator'

extractGeneratorName = (_, appname) ->
  slugged = _.slugify appname
  match = slugged.match /^generator-(.+)/
  return match[1].toLowerCase() if match and match.length is 2
  slugged

githubUserInfo = (name, cb) ->
  github = new GitHubApi version: '3.0.0'
  github.user.getFrom user: name, cb

class GeneratorCoffeeGenerator extends yeoman.generators.Base
  constructor: (args, options, config) ->
    super
    {@realname, @githubUrl} = options
    @currentYear = (new Date()).getFullYear()
    @on 'end', => @installDependencies skipInstall: options['skip-install']
    @pkg = JSON.parse @readFileAsString path.join __dirname, '../package.json'

  askFor: ->
    # have Yeoman greet the user.
    console.log @yeoman

    done = @async()
    generatorName = extractGeneratorName @_, @appname

    prompts = [
      name: 'githubUser'
      message: 'Would you mind telling me your username on GitHub?'
      default: 'someuser'
    ,
      name: 'generatorName'
      message: 'What\'s the base name of your generator?'
      default: generatorName
    ]

    @prompt prompts, (props) =>
      @githubUser = props.githubUser
      @generatorName = props.generatorName
      @appname = 'generator-' + @generatorName
      done()

  userInfo: ->
    return if @realname? and @githubUrl?

    done = @async()

    githubUserInfo @githubUser, (err, res) =>
      @realname = res.name
      @githubUrl = res.html_url
      done()

  projectfiles: ->
    @template '_package.json', 'package.json'
    @template '_travis.yml', '.travis.yml'
    @template 'README.md'
    @template 'LICENSE'

  gitfiles: ->
    @copy '_gitignore', '.gitignore'

  app: ->
    @mkdir 'app'
    @mkdir 'app/templates'
    @template 'app/index.js'
    @template 'app/index.coffee'

  templates: ->
    @copy 'app/temp/_gitkeep', 'app/temp/.gitkeep'
    @copy 'app/templates/_package.json', 'app/templates/_package.json'
    @copy 'app/templates/_gitignore', 'app/templates/_gitignore'
    @copy 'app/templates/_travis.yml', 'app/templates/_travis.yml'
    @copy 'app/templates/LICENSE', 'app/templates/LICENSE'
    @copy 'app/templates/README.md', 'app/templates/README.md'

  tests: ->
    @mkdir 'test'
    @template 'test/app.spec.coffee', 'test/app.spec.coffee'
    @template 'test/mocha.opts', 'test/mocha.opts'

module.exports = GeneratorCoffeeGenerator
