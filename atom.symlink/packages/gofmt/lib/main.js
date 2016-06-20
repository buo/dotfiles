'use babel'

import {CompositeDisposable} from 'atom'
import {Formatter} from './formatter'

export default {
  dependenciesInstalled: null,
  goget: null,
  goconfig: null,
  formatter: null,
  subscriptions: null,

  activate () {
    this.subscriptions = new CompositeDisposable()
    require('atom-package-deps').install('gofmt').then(() => {
      this.dependenciesInstalled = true
      return this.dependenciesInstalled
    }).catch((e) => {
      console.log(e)
    })
    this.getFormatter()
  },

  deactivate () {
    if (this.subscriptions) {
      this.subscriptions.dispose()
    }
    this.subscriptions = null
    this.goget = null
    this.goconfig = null
    this.formatter = null
    this.dependenciesInstalled = null
  },

  provide () {
    return this.getFormatter()
  },

  getFormatter () {
    if (this.formatter) {
      return this.formatter
    }
    this.formatter = new Formatter(() => {
      return this.getGoconfig()
    }, () => {
      return this.getGoget()
    })
    this.subscriptions.add(this.formatter)
    return this.formatter
  },

  getGoconfig () {
    if (this.goconfig) {
      return this.goconfig
    }
    return false
  },

  getGoget () {
    if (this.goget) {
      return this.goget
    }
    return false
  },

  consumeGoconfig (service) {
    this.goconfig = service
    this.getFormatter().updateFormatterCache()
  },

  consumeGoget (service) {
    this.goget = service
  }
}
