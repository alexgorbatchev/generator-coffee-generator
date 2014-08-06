path = require 'path'
fs = require 'fs'
{exec} = require 'child_process'
helpers = require('yeoman-generator').test

GENERATOR_NAME = 'app'
DEST = path.join __dirname, '..', 'temp', "generator-#{GENERATOR_NAME}"

describe 'coffee-generator', ->
  describe 'app', ->
    before (done) ->
      helpers
        .run path.join __dirname, '..', 'app'
        .inDir DEST
        .withOptions
          realname: 'Alex Gorbatchev'
          githubUrl: 'https://github.com/alexgorbatchev'
        .withPrompt
          githubUser: 'alexgorbatchev'
          generatorName: GENERATOR_NAME
        .on 'end', done

    it 'creates expected files', ->
      helpers.assertFile '''
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

  describe 'subgenerator', ->
    before (done) ->
      helpers
        .run path.join __dirname, '..', 'subgenerator'
        .withArguments ['mygen']
        .on 'ready', -> process.chdir DEST
        .on 'end', done

    it 'creates expected files', ->
      expected = """
        mygen/index.coffee
        mygen/index.js
        mygen/templates/somefile.coffee
        test/mygen.spec.coffee
      """.split /\s+/g

      helpers.assertFile expected

  describe 'testing produces generators', ->
    it 'can run npm test', (done) ->
      fs.symlinkSync "#{__dirname}/../node_modules", "#{DEST}/node_modules"

      exec 'npm test', cwd: DEST, (err, stdout, stderr) ->
        console.log stdout.replace /^/gm, '        > '
        done err
