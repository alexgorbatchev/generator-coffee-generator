path = require 'path'
fs = require 'fs'
{exec} = require 'child_process'
helpers = require('yeoman-generator').test

GENERATOR_NAME = 'app'
DEST = path.join __dirname, '..', 'temp', "generator-#{GENERATOR_NAME}"

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
      .gitignore
      .travis.yml
      LICENSE
      README.md
      package.json
    '''.split /\s+/g
