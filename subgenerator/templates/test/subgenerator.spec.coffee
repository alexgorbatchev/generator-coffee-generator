fs      = require 'fs-extra'
path    = require 'path'
helpers = require 'yeoman-test'
assert  = require 'yeoman-assert'

GENERATOR_NAME = '<%= name %>'
DEST = path.join __dirname, '..', 'tmp', "generator-#{GENERATOR_NAME}"

describe '<%= name %>', ->
  before (done) ->
    helpers
      .run path.join __dirname, '..', GENERATOR_NAME
      .inTmpDir (dir) =>
        fs.copySync(DEST, dir)
      .withArguments ['mytest']
      .on 'end', done

  it 'creates expected files', ->
    assert.file '''
      mytest/somefile.coffee
    '''.split /\s+/g
