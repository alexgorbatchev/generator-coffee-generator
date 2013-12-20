require 'coffee-errors'

util = require 'util'
path = require 'path'
url = require 'url'
GitHubApi = require 'github'
yeoman = require 'yeoman-generator'

extractGeneratorName = (_, appname) ->
  slugged = _.slugify(appname)
  match = slugged.match(/^generator-(.+)/)
  return match[1].toLowerCase()  if match and match.length is 2
  slugged

githubUserInfo = (name, cb) ->
  proxy = process.env.http_proxy or process.env.HTTP_PROXY or process.env.https_proxy or process.env.HTTPS_PROXY or null
  githubOptions = version: '3.0.0'

  if proxy
    proxy = url.parse proxy

    githubOptions.proxy =
      host: proxy.hostname
      port: proxy.port

  github = new GitHubApi githubOptions

  github.user.getFrom
    user: name
  , (err, res) ->
    throw err  if err
    cb JSON.parse JSON.stringify res

class GeneratorCoffeeGenerator extends yeoman.generators.Base
  constructor: (args, options, config) ->
    super
    @currentYear = (new Date()).getFullYear()
    @on 'end', => @installDependencies skipInstall: options['skip-install']
    @pkg = JSON.parse @readFileAsString path.join __dirname, '../package.json'

  askFor: ->
    done = @async()
    generatorName = extractGeneratorName @_, @appname

    # have Yeoman greet the user.
    console.log @yeoman

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
    done = @async()

    githubUserInfo @githubUser, (res) =>
      @realname = res.name
      @email = res.email
      @githubUrl = res.html_url
      done()

  projectfiles: ->
    @template '_package.json', 'package.json'
    @template '_travis.yml', '.travis.yml'
    @template 'README.md'
    @template 'LICENSE'

  gitfiles: ->
    @copy 'gitignore', '.gitignore'

  app: ->
    @mkdir 'app'
    @mkdir 'app/templates'
    @template 'app/index.js'
    @template 'app/index.coffee'

  templates: ->
    @copy 'app/templates/_package.json', 'app/templates/_package.json'

  tests: ->
    @mkdir 'test'
    @template 'test/load.spec.coffee', 'test/load.spec.coffee'
    @template 'test/creation.spec.coffee', 'test/creation.spec.coffee'
    @template 'test/mocha.opts', 'test/mocha.opts'

module.exports = GeneratorCoffeeGenerator
