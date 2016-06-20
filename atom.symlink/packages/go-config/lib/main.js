'use babel'

import {CompositeDisposable} from 'atom'
import {isTruthy, isFalsy} from './check'
import {Executor} from './executor'
import semver from 'semver'

export default {
  environment: null,
  locator: null,
  subscriptions: null,
  dependenciesInstalled: null,

  activate () {
    this.dependenciesInstalled = false
    this.subscriptions = new CompositeDisposable()
    if (semver.satisfies(this.version(), '<1.7.0')) {
      require('atom-package-deps').install('go-config').then(() => {
        this.dependenciesInstalled = true
      }).catch((e) => {
        console.log(e)
      })
    } else {
      this.dependenciesInstalled = true
    }
  },

  deactivate () {
    this.dispose()
  },

  dispose () {
    if (isTruthy(this.subscriptions)) {
      this.subscriptions.dispose()
    }
    this.subscriptions = null
    this.environment = null
    this.locator = null
    this.dependenciesInstalled = null
  },

  getExecutor (options) {
    let e = new Executor({environmentFn: this.getEnvironment.bind(this)})
    return e
  },

  getLocator () {
    if (isTruthy(this.locator)) {
      return this.locator
    }
    let Locator = require('./locator').Locator
    this.locator = new Locator({
      environment: this.getEnvironment.bind(this),
      executor: this.getExecutor(),
      ready: this.ready.bind(this)
    })
    this.subscriptions.add(this.locator)
    return this.locator
  },

  ready () {
    if (isFalsy(this.dependenciesInstalled)) {
      return false
    }
    if (semver.satisfies(this.version(), '>=1.7.0')) {
      return true
    } else {
      if (isTruthy(this.environment)) {
        return true
      } else {
        return false
      }
    }
  },

  getEnvironment () {
    if (semver.satisfies(this.version(), '>=1.7.0')) {
      return process.env
    }

    if (this.ready()) {
      return this.environment
    }

    return process.env
  },

  version () {
    return semver.major(atom.appVersion) + '.' + semver.minor(atom.appVersion) + '.' + semver.patch(atom.appVersion)
  },

  provide () {
    return this.get100Implementation()
  },

  provide010 () {
    return this.get010Implementation()
  },

  get100Implementation () {
    let executor = this.getExecutor()
    let locator = this.getLocator()
    return {
      executor: {
        exec: executor.exec.bind(executor),
        execSync: executor.execSync.bind(executor)
      },
      locator: {
        runtimes: locator.runtimes.bind(locator),
        runtime: locator.runtime.bind(locator),
        gopath: locator.gopath.bind(locator),
        findTool: locator.findTool.bind(locator)
      },
      environment: locator.environment.bind(locator)
    }
  },

  get010Implementation () {
    let executor = this.getExecutor()
    let locator = this.getLocator()
    return {
      executor: executor,
      locator: locator,
      environment: this.getEnvironment.bind(this)
    }
  },

  consumeEnvironment (environment) {
    this.environment = environment
  }
}
