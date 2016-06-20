# `navigator-godef` [![Build Status](https://travis-ci.org/joefitzgerald/navigator-godef.svg?branch=master)](https://travis-ci.org/joefitzgerald/navigator-godef) [![Build status](https://ci.appveyor.com/api/projects/status/kkuftvp09beng3nm/branch/master?svg=true)](https://ci.appveyor.com/project/joefitzgerald/navigator-godef/branch/master)

> **[godef](https://github.com/rogpeppe/godef)**
>
> Find symbol information in Go source. `godef`, given an expression or a
> location in a source file, prints the location of the definition of the
> symbol referred to.
> Known limitations:
>
> - it does not understand about "." imports
> - it does not like imports where the last element import path doesn't match
> the package identifier.

`navigator-godef` runs `godef` and jumps to the definition of the symbol under
the cursor, if it can be found. It depends on the following packages:

* [`go-config`](https://atom.io/packages/go-config)
* [`go-get`](https://atom.io/packages/go-get)

## Contributors

In addition to https://github.com/joefitzgerald/navigator-godef/graphs/contributors, this package is based on work done by the following people for [go-plus](https://github.com/joefitzgerald/go-plus):

* [Crispin Bennett](https://github.com/crispinb) [here](https://github.com/joefitzgerald/go-plus/pull/137)
* [Darshan Shaligram](https://github.com/greensnark) [here](https://github.com/joefitzgerald/go-plus/pull/261) and [here](https://github.com/joefitzgerald/go-plus/pull/265)
* [Matt Smith](https://github.com/ma314smith) [here](https://github.com/joefitzgerald/go-plus/pull/234) and  [here](https://github.com/joefitzgerald/go-plus/pull/239)
* [Miguel Perez](https://github.com/miguel250) [here](https://github.com/joefitzgerald/go-plus/pull/227)
