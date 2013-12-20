assert = require 'assert'

describe '<%= generatorName %> load', ->
  it 'can be imported without blowing up', ->
    app = require('../app')
    assert app?

