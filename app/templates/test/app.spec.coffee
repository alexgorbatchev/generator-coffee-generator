path    = require 'path'
fs      = require 'fs-extra'
helpers = require 'yeoman-test'
assert  = require 'yeoman-assert'

GENERATOR_NAME = 'app'
DEST = path.join __dirname, '..', 'tmp', "generator-#{GENERATOR_NAME}"

describe 'app', ->
  before (done) ->
    helpers
      .run path.join __dirname, '..', 'app'
      .inTmpDir (dir) =>
        fs.copySync(DEST, dir)
      .withOptions
        realname: 'Alex Gorbatchev'
        githubUrl: 'https://github.com/alexgorbatchev'
      .withPrompts
        githubUser: 'alexgorbatchev'
        generatorName: GENERATOR_NAME
      .on 'end', done

  it 'creates expected files', ->
    assert.file '''
      .gitignore
      .travis.yml
      LICENSE
      README.md
      package.json
    '''.split /\s+/g
