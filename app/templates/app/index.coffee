require 'coffee-errors'

htmlWiring = require 'html-wiring'
_          = require 'lodash'
path       = require 'path'
yeoman     = require 'yeoman-generator'

helpers    = require './helpers'

class <%= className %>Generator extends yeoman.Base
  constructor: (args, options) ->
    super
    @option 'github-user'
    @currentYear = (new Date()).getFullYear()
    {@realname, @githubUrl} = options
    @skipInstall = options['skip-install']
    @githubUser  = options['github-user']
    @pkg = JSON.parse htmlWiring.readFileAsString path.join __dirname, '../package.json'

  initializing: =>
    @appname = _.kebabCase @appname

  prompting: =>
    return if @githubUser?
    done = @async()

    prompts = [
      name: 'githubUser'
      message: 'Would you mind telling me your username on GitHub?'
      default: 'octoblu'
    ]

    @prompt(prompts).then (props) =>
      @githubUser = props.githubUser
      done()

  userInfo: =>
    return if @realname? and @githubUrl?

    done = @async()

    console.log 'here'
    helpers.githubUserInfo @githubUser, (error, res) =>
      console.log "not 'here'"
      @env.error error if error?
      @realname = res.name
      @email = res.email
      @githubUrl = res.html_url
      done()

  configuring: =>
    @copy '_gitignore', '.gitignore'

  writing: =>
    context = {@appname, @githubUrl, @realname}

    @template '_package.json', 'package.json', context
    @template '_travis.yml', '.travis.yml', context
    @template '_README.md', 'README.md', context
    @template '_LICENSE', 'LICENSE', context

  install: =>
    return if @skipInstall
    @installDependencies npm: true, bower: false

  end: =>
    return if @skipInstall

module.exports = <%= className %>Generator
