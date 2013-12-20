path = require 'path'
helpers = require('yeoman-generator').test

describe 'express-app creation', ->
  beforeEach (done) ->
    helpers.testDirectory path.join(__dirname, 'temp'), (err) =>
      return done(err) if err

      @app = helpers.createGenerator 'coffee-generator:app', ['../../app']
      done()

  it 'creates expected files', (done) ->
    # add files you expect to exist here.
    expected = 'package.json README.md LICENSE .travis.yml .gitignore'.split /\s+/g
    helpers.mockPrompt @app, someOption: true

    @app.options['skip-install'] = true

    @app.userInfo = ->
      this.realname = 'Alex Gorbatchev';
      this.email = 'alex.gorbatchev@world.com';
      this.githubUrl = 'https://github.com/alexgorbatchev';

    helpers.mockPrompt @app,
      githubUser: 'alexgorbatchev'
      generatorName: 'temp'

    @app.run {}, ->
      helpers.assertFiles expected
      done()
