{before, describe, it} = global

path    = require 'path'
fs      = require 'fs-extra'
helpers = require 'yeoman-test'
assert  = require 'yeoman-assert'

GENERATOR_NAME = 'app'
DEST           = path.join __dirname, '..', 'tmp', "generator-#{GENERATOR_NAME}"

describe 'app', ->
  before (done) ->
    fs.mkdirsSync DEST
    helpers
      .run path.join __dirname, '..', GENERATOR_NAME
      .inDir DEST
      .withOptions
        realname: 'Octoblu, Inc'
        githubUrl: 'https://github.com/octoblu'
      .withPrompts
        githubUser: 'octoblu'
        generatorName: GENERATOR_NAME
      .on 'end', done

  it 'creates expected files', ->
    assert.file [
      '.gitignore'
      '.travis.yml'
      'LICENSE'
      'README.md'
      'package.json'
    ]
