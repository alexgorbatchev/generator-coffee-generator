path = require 'path'
helpers = require('yeoman-generator').test

describe 'express-app creation', ->
  beforeEach (done) ->
    helpers.testDirectory path.join(__dirname, "temp"), (err) =>
      return done(err) if err
      @app = helpers.createGenerator "express-app:app", ["../../app"]
      done()

  it "creates expected files", (done) ->
    # add files you expect to exist here.
    expected = [".jshintrc", ".editorconfig"]
    helpers.mockPrompt @app,
      someOption: true

    @app.options["skip-install"] = true
    @app.run {}, ->
      helpers.assertFiles expected
      done()
