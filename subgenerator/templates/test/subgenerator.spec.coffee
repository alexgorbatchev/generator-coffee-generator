path = require 'path'
helpers = require('yeoman-generator').test

GENERATOR_NAME = '<%= generatorName %>'
DEST = path.join __dirname, '..', 'temp', "generator-#{GENERATOR_NAME}"

describe '<%= generatorName %>', ->
  beforeEach (done) ->
    helpers.testDirectory DEST, (err) =>
      return done(err) if err

      @app = helpers.createGenerator 'coffee-generator:<%= generatorName %>', ['../../<%= generatorName %>'], [GENERATOR_NAME]
      done()

  it 'creates expected files', (done) ->
    expected = """
      #{GENERATOR_NAME}/somefile.coffee
    """.split /\s+/g

    helpers.mockPrompt @app,
      name: GENERATOR_NAME

    @app.run {}, ->
      helpers.assertFile expected
      done()
