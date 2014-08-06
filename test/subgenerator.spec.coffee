path = require 'path'
helpers = require('yeoman-generator').test

GENERATOR_NAME = 'subgenerator'
DEST = path.join __dirname, '..', 'temp', "generator-#{GENERATOR_NAME}"

createMainGenerator = (done) ->
  helpers.testDirectory DEST, (err) =>
    return done err if err?

    app = helpers.createGenerator 'coffee-generator:app', ['../../app']
    app.options['skip-install'] = true

    app.userInfo = ->
      @realname = 'Alex Gorbatchev';
      @email = 'alex.gorbatchev@world.com';
      @githubUrl = 'https://github.com/alexgorbatchev';

    helpers.mockPrompt app,
      githubUser: 'alexgorbatchev'
      generatorName: GENERATOR_NAME

    app.run {}, done

describe 'subgenerator', ->
  before (done) ->
    createMainGenerator =>
      @app = helpers.createGenerator 'coffee-generator:subgenerator', ['../../subgenerator'], [GENERATOR_NAME]
      done()

  it 'creates expected files', (done) ->
    expected = """
      #{DEST}/#{GENERATOR_NAME}/index.coffee
      #{DEST}/#{GENERATOR_NAME}/index.js
      #{DEST}/#{GENERATOR_NAME}/templates/somefile.coffee
      #{DEST}/test/#{GENERATOR_NAME}.spec.coffee
    """.split /\s+/g

    @app.run {}, ->
      helpers.assertFile expected
      done()
