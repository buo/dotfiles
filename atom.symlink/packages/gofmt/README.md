# `gofmt` Atom Formatter [![Build Status](https://travis-ci.org/joefitzgerald/gofmt.svg?branch=master)](https://travis-ci.org/joefitzgerald/gofmt) [![Build status](https://ci.appveyor.com/api/projects/status/03gyxrjik1vuhu0e/branch/master?svg=true)](https://ci.appveyor.com/project/joefitzgerald/gofmt/branch/master)

`gofmt` runs [`gofmt`](https://golang.org/cmd/gofmt/), [`goimports`](https://godoc.org/golang.org/x/tools/cmd/goimports), or [`goreturns`](https://github.com/sqs/goreturns) on save. It also provides commands to run them on-demand.

It depends on the following packages:

* [`go-config`](https://atom.io/packages/go-config)
* [`go-get`](https://atom.io/packages/go-get)
