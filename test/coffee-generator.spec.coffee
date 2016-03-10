path       = require 'path'
fs         = require 'fs-extra'
{execSync} = require 'child_process'
helpers    = require 'yeoman-test'
assert     = require 'yeoman-assert'

GENERATOR_NAME = 'app-service'
DEST           = path.join __dirname, '..', 'tmp', "generator-#{GENERATOR_NAME}"

describe 'coffee-generator', ->
  beforeEach (done) ->
    console.log 'mkdirs', DEST
    fs.mkdirs DEST, done

  describe 'app-service', ->
    before (done) ->
      helpers
        .run path.join __dirname, '..', 'app'
        .inTmpDir (dir) =>
          fs.copySync DEST, dir
        .withOptions
          realname: 'Octoblu, Inc'
          githubUrl: 'https://github.com/octoblu'
        .withPrompts
          githubUser: 'octoblu'
          generatorName: GENERATOR_NAME
        .on 'end', done

    it 'creates expected files', ->
      assert.file '''
        app/index.coffee
        app/index.js
        app/templates/_gitignore
        app/templates/_package.json
        app/templates/_travis.yml
        app/templates/README.md
        app/templates/LICENSE
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
        .on 'ready', ->
          process.chdir DEST
        .on 'end', done

    it 'creates expected files', ->
      expected = """
        mygen/index.coffee
        mygen/index.js
        mygen/templates/somefile.coffee
        test/mygen.spec.coffee
      """.split /\s+/g

      assert.file expected

  describe 'testing produces generators', ->
    it 'can run npm test', ->
      fs.symlinkSync "#{__dirname}/../node_modules", "#{DEST}/node_modules"

      execSync 'npm test', cwd: DEST
