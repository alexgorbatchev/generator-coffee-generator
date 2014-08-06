# generator-coffee-generator

[![GitTip](http://img.shields.io/gittip/alexgorbatchev.svg?style=flat)](https://www.gittip.com/alexgorbatchev/)
[![Dependency status](http://img.shields.io/david/alexgorbatchev/generator-coffee-generator.svg?style=flat)](https://david-dm.org/alexgorbatchev/generator-coffee-generator)
[![devDependency Status](http://img.shields.io/david/dev/alexgorbatchev/generator-coffee-generator.svg?style=flat)](https://david-dm.org/alexgorbatchev/generator-coffee-generator#info=devDependencies)
[![Build Status](http://img.shields.io/travis/alexgorbatchev/generator-coffee-generator.svg?style=flat&branch=master)](https://travis-ci.org/alexgorbatchev/generator-coffee-generator)

[![NPM](https://nodei.co/npm/generator-coffee-generator.svg?style=flat)](https://npmjs.org/package/generator-coffee-generator)

[Yeoman](http://yeoman.io) generator that scaffolds out a new basic Yeoman generator with some sensible defaults written in CoffeeScript.

![](http://i.imgur.com/JHaAlBJ.png)

## Support

Please help me spend more time developing and maintaining awesome modules like this by donating!

The absolute best thing to do is to sign up with [Gittip](http://gittip.com) if you haven't already and donate just $1 a week. That is roughly a cup of coffee per month. Also, please do donate to many other amazing open source projects!

[![Gittip](http://img.shields.io/gittip/alexgorbatchev.png?style=flat)](https://www.gittip.com/alexgorbatchev/)
[![PayPayl donate button](http://img.shields.io/paypal/donate.png?color=yellow&style=flat)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=PSDPM9268P8RW "Donate once-off to this project using Paypal")

## Installing

    npm install -g generator-coffee-generator

## Generators

### coffee-generator

    yo coffee-generator

Shows a wizard for generating a new generator and generates the following in the current folder:

    .
    ├── app
    │   ├── index.js
    │   ├── index.coffee
    │   └── templates
    │       └── _package.json
    ├── test
    |   ├── app.spec.coffee
    |   └── mocha.opts
    ├── .gitignore
    ├── LICENSE
    ├── README.md
    └── package.json

### coffee-generator:subgenerator NAME

    yo coffee-generator:subgenerator NAME

Generates a subgenerator with the name `NAME` in the current folder:

    .
    ├── NAME
    │   └── index.coffee
    └── test
        └── NAME.spec.coffee

## Testing

    npm test

## License

The MIT License (MIT)

Copyright (c) 2013-2014 Alex Gorbatchev

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
