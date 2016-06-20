# `go-config` For Atom [![Build Status](https://travis-ci.org/joefitzgerald/go-config.svg)](https://travis-ci.org/joefitzgerald/go-config) [![Build status](https://ci.appveyor.com/api/projects/status/sh7nepkf0cvt7r6j?svg=true)](https://ci.appveyor.com/project/joefitzgerald/go-config)

`go-config` detects your go installation(s), tool(s), and associated configuration. You can optionally configure the package to provide hints for go installations tools.

This package provides an API via an Atom service. This API can be used by other packages that need to work with the `go` tool, other related tools (e.g. `gofmt`, `vet`, etc.) or `$GOPATH/bin` tools (e.g. `goimports`, `goreturns`, etc.).

This package needs the [environment](https://atom.io/packages/environment) package installed to function correctly in all circumstances. If [environment](https://atom.io/packages/environment) is not installed, you may experience issues on OS X on versions of Atom < 1.7.0. You can safely uninstall environment for versions of Atom >= 1.7.0.
