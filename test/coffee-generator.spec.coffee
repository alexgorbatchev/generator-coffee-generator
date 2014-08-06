path = require 'path'
fs = require 'fs'
rimraf = require 'rimraf'
{exec} = require 'child_process'
helpers = require('yeoman-generator').test

GENERATOR_NAME = 'app'
DEST = path.join __dirname, '..', 'temp', "generator-#{GENERATOR_NAME}"

describe 'app', ->
  before (done) ->
    helpers.testDirectory DEST, (err) =>
      return done(err) if err
      @app = helpers.createGenerator 'coffee-generator:app', ['../../app']
      done()

  # after (done) ->
  #   rimraf DEST, done

  it 'creates expected files', (done) ->
    expected = '''
      app/index.coffee
      app/index.js
      app/templates/_gitignore
      app/templates/_package.json
      app/templates/_travis.yml
      app/templates/README.md
      app/templates/LICENSE
      app/temp/.gitkeep
      package.json
      README.md
      LICENSE
      .travis.yml
      .gitignore
    '''.split /\s+/g

    @app.options['skip-install'] = true

    @app.userInfo = ->
      @realname = 'Alex Gorbatchev';
      @email = 'alex.gorbatchev@world.com';
      @githubUrl = 'https://github.com/alexgorbatchev';

    helpers.mockPrompt @app,
      githubUser: 'alexgorbatchev'
      generatorName: GENERATOR_NAME

    @app.run {}, ->
      helpers.assertFile expected
      done()

  it 'can run generated generator', (done) ->
    fs.symlinkSync "#{__dirname}/../node_modules", "#{DEST}/node_modules"

    exec 'npm test', cwd: DEST, (err, stdout, stderr) ->
      console.log stdout.replace /^/gm, '   > '
      done err
