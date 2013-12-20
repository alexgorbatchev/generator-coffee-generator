# generator-coffee-generator [![Gittip](http://img.shields.io/gittip/alexgorbatchev.png)](https://www.gittip.com/alexgorbatchev/)

[Yeoman](http://yeoman.io) generator that scaffolds out a new basic Yeoman generator with some sensible defaults written in CoffeeScript.

[![Dependency status](https://david-dm.org/alexgorbatchev/generator-coffee-generator.png)](https://david-dm.org/alexgorbatchev/generator-coffee-generator) [![Build Status](https://secure.travis-ci.org/alexgorbatchev/generator-coffee-generator.png?branch=master)](https://travis-ci.org/alexgorbatchev/generator-coffee-generator)

![](http://i.imgur.com/JHaAlBJ.png)

## Getting started

- Install: `npm install -g generator-coffee-generator`
- Run: `yo coffee-generator`

## Commands

* `yo coffee-generator` shows a wizard for generating a new generator
* `yo coffee-generator:subgenerator NAME` generates a subgenerator with the name NAME

## What do you get?

Scaffolds out a complete project directory structure for you:

    .
    ├── app
    │   ├── index.js
    │   ├── index.coffee
    │   └── templates
    │       └── _package.json
    ├── .gitignore
    ├── LICENSE
    ├── package.json
    ├── README.md
    └── test
        ├── app.spec.coffee
        ├── load.spec.coffee
        └── mocha.opts

## License

[MIT License](http://en.wikipedia.org/wiki/MIT_License)
