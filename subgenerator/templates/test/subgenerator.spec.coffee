path = require 'path'
helpers = require('yeoman-generator').test

GENERATOR_NAME = '<%= name %>'
DEST = path.join __dirname, '..', 'temp', "generator-#{GENERATOR_NAME}"

describe '<%= name %>', ->
  before (done) ->
    helpers
      .run path.join __dirname, '..', GENERATOR_NAME
      .inDir DEST
      .withArguments ['mytest']
      .on 'end', done

  it 'creates expected files', ->
    helpers.assertFile '''
      mytest/somefile.coffee
    '''.split /\s+/g
