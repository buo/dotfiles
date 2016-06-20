'use babel'

import {CompositeDisposable} from 'atom'
import {Manager} from './manager'

export default {
  dependenciesInstalled: null,
  goconfig: null,
  manager: null,
  subscriptions: null,

  activate () {
    this.subscriptions = new CompositeDisposable()
    require('atom-package-deps').install('go-get').then(() => {
      this.dependenciesInstalled = true
    }).catch((e) => {
      console.log(e)
    })
    this.getManager()
  },

  deactivate () {
    if (this.subscriptions) {
      this.subscriptions.dispose()
    }
    this.subscriptions = null
    this.goconfig = null
    this.manager = null
    this.dependenciesInstalled = null
  },

  provide () {
    return this.getProvider()
  },

  getManager () {
    if (this.manager) {
      return this.manager
    }
    this.manager = new Manager(() => { return this.getGoconfig() })
    this.subscriptions.add(this.manager)
    return this.manager
  },

  getProvider () {
    return {
      get: (options) => {
        return this.getManager().get(options)
      },
      check: (options) => {
        return this.getManager().check(options)
      }
    }
  },

  getGoconfig () {
    if (this.goconfig) {
      return this.goconfig
    }
    return false
  },

  consumeGoconfig (service) {
    this.goconfig = service
  }
}
