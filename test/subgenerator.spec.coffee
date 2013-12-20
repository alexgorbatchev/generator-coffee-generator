path = require 'path'
helpers = require('yeoman-generator').test

describe 'subgenerator', ->
  beforeEach (done) ->
    helpers.testDirectory path.join(__dirname, 'subgenerator.tmp'), (err) =>
      return done(err) if err

      @app = helpers.createGenerator 'coffee-generator:subgenerator', ['../../subgenerator'], ['foo']
      done()

  it 'creates expected files', (done) ->
    expected = 'foo/index.coffee foo/index.js foo/templates/somefile.coffee'.split /\s+/g
    helpers.mockPrompt @app, someOption: true

    @app.options['skip-install'] = true

    @app.run {}, ->
      helpers.assertFiles expected
      done()
