# linter-less

[![Build Status](https://img.shields.io/travis/josa42/atom-linter-less.svg?style=flat-square)](https://travis-ci.org/josa42/atom-linter-less)
[![Plugin installs!](https://img.shields.io/apm/dm/linter-less.svg?style=flat-square)](https://atom.io/packages/linter-less)
[![Package version!](https://img.shields.io/apm/v/linter-less.svg?style=flat-square)](https://atom.io/packages/linter-less)
[![Dependencies!](https://img.shields.io/david/josa42/atom-linter-less.svg?style=flat-square)](https://david-dm.org/josa42/atom-linter-less)


This linter plugin for [Linter](https://github.com/atom-community/linter) provides an interface to [less](http://lesscss.org).

## Configuration

* **Ignore undefined global variables:** Ignore variables marked as global e.g. `// global: @fontSize`
* **Ignore undefined variables**
* **IE Compatibility Checks**
* **Strict Math:** Turn on or off strict math, where in strict mode, math requires brackets.
* **Strict Units:** Allow mixed units, e.g. `1px+1em` or `1px*1px` which have units that cannot be represented.
* **Ignore .lessrc configutation file**

See also: [lesscss.org](http://lesscss.org/usage/#command-line-usage).

## Configuration File (`.lessrc`)

```JSON
{
  "paths": [],
  "ieCompat": true,
  "strictUnits": false
}
```
