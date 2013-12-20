path = require 'path'
helpers = require('yeoman-generator').test

describe '<%= generatorName %> creation', ->
  beforeEach (done) ->
    helpers.testDirectory path.join(__dirname, 'temp'), (err) =>
      return done(err) if err
      @app = helpers.createGenerator '<%= generatorName %>:app', ['../../app']
      done()

  it 'creates expected files', (done) ->
    # add files you expect to exist here.
    expected = ['package.json']
    helpers.mockPrompt @app, someOption: true

    @app.options['skip-install'] = true
    @app.run {}, ->
      helpers.assertFiles expected
      done()
