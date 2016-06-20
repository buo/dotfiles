# `builder-go` [![Build Status](https://travis-ci.org/joefitzgerald/builder-go.svg?branch=master)](https://travis-ci.org/joefitzgerald/builder-go) [![Build status](https://ci.appveyor.com/api/projects/status/94xc9j658w69cri9/branch/master?svg=true)](https://ci.appveyor.com/project/joefitzgerald/builder-go/branch/master)

`builder-go` is a [Linter](https://atom.io/packages/linter) provider that builds your go source code and allows you to see syntax or compilation errors. It depends on the following packages:

* [`go-config`](https://atom.io/packages/go-config)

## How Are The Builds Performed?

The following commands are run for the directory of the current file:
* `go install .` (for normal `.go` files)
* `go test -o {tmpdir} -c .` (for `_test.go` files)

## Why Are You Running `go install` Instead Of `go build`?

`gocode` (and a few other tools, like `gotype`) work on `.a` files (i.e. the package object archive), and the way to keep these up to date is to run `go install` periodically. This ensures your autocomplete suggestions are kept up to date without having to resort to `gocode set autobuild true` :tada:.

## But What About `gb`?

I'm open to suggestions for detecting a package which is built with gb; please feel free to submit a pull request that detects a gb package without any explicit configuration and runs it.
