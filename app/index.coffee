require 'coffee-errors'

_          = require 'lodash'
util       = require 'util'
path       = require 'path'
fs         = require 'fs'
url        = require 'url'
GitHubApi  = require 'github'
yeoman     = require 'yeoman-generator'
HTMLWiring = require 'html-wiring'
mkdirp     = require 'mkdirp'

extractGeneratorName = (appname) ->
  slugged = _.kebabCase appname
  match = slugged.match /^generator-(.+)/
  return match[1].toLowerCase() if match and match.length is 2
  slugged

githubUserInfo = (name, cb) ->
  github = new GitHubApi version: '3.0.0'
  github.user.getFrom user: name, cb

class GeneratorCoffeeGenerator extends yeoman.Base
  constructor: (args, options, config) ->
    super
    {@realname, @githubUrl} = options
    @currentYear = (new Date()).getFullYear()
    @on 'end', => @installDependencies skipInstall: options['skip-install']
    @pkg = JSON.parse HTMLWiring.readFileAsString path.join __dirname, '../package.json'

  askFor: ->
    done = @async()
    generatorName = extractGeneratorName @appname

    prompts = [
      name: 'githubUser'
      message: 'Would you mind telling me your username on GitHub?'
      default: 'octoblu'
    ,
      name: 'generatorName'
      message: 'What\'s the base name of your generator?'
      default: generatorName
    ]

    @prompt prompts, (props) =>
      @githubUser = props.githubUser
      @generatorName = props.generatorName
      @appname = 'generator-' + @generatorName
      @appNameWithGenerator = _.kebabCase(@appname)
      @className = _.upperFirst(_.camelCase(@generatorName))
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
    mkdirp 'app'
    mkdirp 'app/templates'
    @template 'app/index.js'
    @template 'app/index.coffee'

  templates: ->
    @copy 'app/templates/_package.json', 'app/templates/_package.json'
    @copy 'app/templates/_gitignore', 'app/templates/_gitignore'
    @copy 'app/templates/_travis.yml', 'app/templates/_travis.yml'
    @copy 'app/templates/LICENSE', 'app/templates/LICENSE'
    @copy 'app/templates/README.md', 'app/templates/README.md'

  tests: ->
    mkdirp 'test'
    @template 'test/app.spec.coffee', 'test/app.spec.coffee'
    @template 'test/mocha.opts', 'test/mocha.opts'

module.exports = GeneratorCoffeeGenerator
