# `tester-go` Atom Tester [![Build Status](https://travis-ci.org/joefitzgerald/tester-go.svg?branch=master)](https://travis-ci.org/joefitzgerald/tester-go) [![Build status](https://ci.appveyor.com/api/projects/status/wgivdhtdd0foyylw/branch/master?svg=true)](https://ci.appveyor.com/project/joefitzgerald/tester-go/branch/master)

`tester-go` runs `go test -coverprofile` on your code and then displays coverage
information in the editor. You can optionally configure this to be done
automatically on save.

It depends on the following packages:

* [`go-config`](https://atom.io/packages/go-config)
* [`go-get`](https://atom.io/packages/go-get)

## Configuration

* `runCoverageOnSave`: Run `go test -coverprofile` on the current package each
time you save a `.go` file (default: `false`)
