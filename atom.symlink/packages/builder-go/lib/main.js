'use babel'

import {CompositeDisposable} from 'atom'
import {Builder} from './builder'

export default {
  dependenciesInstalled: null,
  goconfig: null,
  builder: null,
  subscriptions: null,

  activate () {
    this.subscriptions = new CompositeDisposable()
    require('atom-package-deps').install('builder-go').then(() => {
      this.dependenciesInstalled = true
      return this.dependenciesInstalled
    }).catch((e) => {
      console.log(e)
    })
  },

  deactivate () {
    if (this.subscriptions) {
      this.subscriptions.dispose()
    }
    this.subscriptions = null
    this.goconfig = null
    this.builder = null
    this.dependenciesInstalled = null
  },

  provide () {
    let builder = this.getBuilder()
    return builder
  },

  getBuilder () {
    if (this.builder) {
      return this.builder
    }
    this.builder = new Builder(
      () => { return this.getGoconfig() }
    )
    this.subscriptions.add(this.builder)
    return this.builder
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
