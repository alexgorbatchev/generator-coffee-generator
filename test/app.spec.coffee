path = require 'path'
helpers = require('yeoman-generator').test

describe 'app', ->
  beforeEach (done) ->
    helpers.testDirectory path.join(__dirname, 'app.tmp'), (err) =>
      return done(err) if err
      @app = helpers.createGenerator 'coffee-generator:app', ['../../app']
      done()

  it 'creates expected files', (done) ->
    # add files you expect to exist here.
    expected = 'package.json README.md LICENSE .travis.yml .gitignore'.split /\s+/g
    helpers.mockPrompt @app, someOption: true

    @app.options['skip-install'] = true

    @app.userInfo = ->
      @realname = 'Alex Gorbatchev';
      @email = 'alex.gorbatchev@world.com';
      @githubUrl = 'https://github.com/alexgorbatchev';

    helpers.mockPrompt @app,
      githubUser: 'alexgorbatchev'
      generatorName: 'temp'

    @app.run {}, ->
      helpers.assertFiles expected
      done()
