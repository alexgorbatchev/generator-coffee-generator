{before, describe, it} = global

path       = require 'path'
fs         = require 'fs-extra'
{execSync} = require 'child_process'
helpers    = require 'yeoman-test'
assert     = require 'yeoman-assert'

GENERATOR_NAME = 'app-service'
DEST           = path.join __dirname, '..', 'tmp', "generator-#{GENERATOR_NAME}"

describe 'coffee-generator', ->
  before 'mkdirs', (done) ->
    @timeout 5000
    fs.mkdirs DEST, done

  describe 'app-service', ->
    before 'app-service', (done) ->
      @timeout 5000
      helpers
        .run path.join __dirname, '..', 'app'
        .inDir DEST
        .withOptions
          realname: 'Octoblu, Inc'
          githubUrl: 'https://github.com/octoblu'
        .withPrompts
          githubUser: 'octoblu'
          generatorName: GENERATOR_NAME
        .on 'end', done

    it 'creates expected files', ->
      assert.file([
        'app/index.coffee'
        'app/index.js'
        'app/templates/_gitignore'
        'app/templates/_package.json'
        'app/templates/_travis.yml'
        'app/templates/_README.md'
        'app/templates/_LICENSE'
        'package.json'
        'README.md'
        'LICENSE'
        '.travis.yml'
        '.gitignore'
      ])

    describe 'testing produces generators', ->
      it 'can run npm test', ->
        fs.symlinkSync "#{__dirname}/../node_modules", "#{DEST}/node_modules"
        execSync 'npm test', cwd: DEST
