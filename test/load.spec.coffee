assert = require("assert")

describe 'express-app load', ->
  it 'can be imported without blowing up', ->
    app = require('../app')
    assert app?

