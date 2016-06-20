# `go-get` [![Build Status](https://travis-ci.org/joefitzgerald/go-get.svg?branch=master)](https://travis-ci.org/joefitzgerald/go-get) [![Build status](https://ci.appveyor.com/api/projects/status/qdu5k1n7a5cgm1hp?svg=true)](https://ci.appveyor.com/project/joefitzgerald/go-get)

An Atom package that uses the `go` tool to fetch and update dependencies. An Atom [`service`](https://atom.io/docs/latest/behind-atom-interacting-with-other-packages-via-services) is provided so that other packages can prompt a user to install a go library or tool.

### Prerequisites

This package requires the following packages to be installed:

* [`environment`](https://atom.io/packages/environment)
* [`go-config`](https://atom.io/packages/go-config)
