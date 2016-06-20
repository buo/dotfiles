'use babel'

import {CompositeDisposable} from 'atom'
import _ from 'lodash'
import fs from 'fs'
import parser from './gocover-parser'
import path from 'path'
import rimraf from 'rimraf'
import temp from 'temp'

class Tester {
  constructor (goconfigFunc, gogetFunc) {
    this.goget = gogetFunc
    this.goconfig = goconfigFunc
    this.subscriptions = new CompositeDisposable()
    this.saveSubscriptions = new CompositeDisposable()
    this.observeConfig()
    this.observeTextEditors()
    this.handleCommands()
    this.subscribeToSaveEvents()
    this.running = false
    temp.track()
  }

  dispose () {
    this.running = true
    this.removeTempDir()
    if (this.subscriptions) {
      this.subscriptions.dispose()
    }
    this.subscriptions = null
    if (this.saveSubscriptions) {
      this.saveSubscriptions.dispose()
    }
    this.saveSubscriptions = null
    this.goget = null
    this.goconfig = null
    this.running = null
  }

  handleCommands () {
    this.subscriptions.add(atom.commands.add('atom-workspace', 'golang:gocover', () => {
      if (!this.ready() || !this.getEditor()) {
        return
      }
      this.runCoverage()
    }))
    this.subscriptions.add(atom.commands.add('atom-workspace', 'golang:cleargocover', () => {
      if (!this.ready() || !this.getEditor()) {
        return
      }
      this.clearMarkersFromEditors()
    }))
  }

  observeTextEditors () {
    this.subscriptions.add(atom.workspace.observeTextEditors((editor) => {
      this.addMarkersToEditor(editor)
    }))
  }

  observeConfig () {
    this.subscriptions.add(atom.config.observe('tester-go.runCoverageOnSave', (runCoverageOnSave) => {
      if (this.saveSubscriptions) {
        this.saveSubscriptions.dispose()
      }
      this.saveSubscriptions = new CompositeDisposable()
      if (runCoverageOnSave) {
        this.subscribeToSaveEvents()
      }
    }))
  }

  subscribeToSaveEvents () {
    this.saveSubscriptions.add(atom.workspace.observeTextEditors((editor) => {
      if (!editor || !editor.getBuffer()) {
        return
      }

      let bufferSubscriptions = new CompositeDisposable()
      bufferSubscriptions.add(editor.getBuffer().onDidSave((filePath) => {
        if (atom.config.get('tester-go.runCoverageOnSave')) {
          this.runCoverage(editor)
          return
        }
      }))
      bufferSubscriptions.add(editor.getBuffer().onDidDestroy(() => {
        bufferSubscriptions.dispose()
      }))
      this.saveSubscriptions.add(bufferSubscriptions)
    }))
  }

  getEditor () {
    if (!atom || !atom.workspace) {
      return
    }
    let editor = atom.workspace.getActiveTextEditor()
    if (!this.isValidEditor(editor)) {
      return
    }

    return editor
  }

  isValidEditor (editor) {
    if (!editor || !editor.getGrammar()) {
      return false
    }

    return editor.getGrammar().scopeName === 'source.go'
  }

  addMarkersToEditors () {
    let editors = atom.workspace.getTextEditors()
    for (let editor of editors) {
      this.addMarkersToEditor(editor)
    }
  }

  clearMarkersFromEditors () {
    let editors = atom.workspace.getTextEditors()
    for (let editor of editors) {
      this.clearMarkers(editor)
    }
  }

  addMarkersToEditor (editor) {
    if (!this.isValidEditor(editor)) {
      return
    }
    let file = editor.getPath()
    let buffer = editor.getBuffer()
    if (!file || !buffer) {
      return
    }
    this.clearMarkers(editor)
    if (!this.ranges || this.ranges.length <= 0) {
      return
    }

    let editorRanges = _.filter(this.ranges, (r) => { return _.endsWith(file, r.file) })

    if (!editorRanges || editorRanges.length <= 0) {
      return
    }

    try {
      for (let range of editorRanges) {
        let marker = buffer.markRange(range.range, {class: 'gocover', gocovercount: range.count, invalidate: 'touch'})
        let c = 'uncovered'
        if (range.count > 0) {
          c = 'covered'
        }
        editor.decorateMarker(marker, {type: 'highlight', class: c, onlyNonEmpty: true})
      }
    } catch (e) {
      console.log(e)
    }
  }

  clearMarkers (editor) {
    if (!editor || !editor.getBuffer()) {
      return
    }

    try {
      let markers = editor.getBuffer().findMarkers({class: 'gocover'})
      if (!markers || markers.length <= 0) {
        return
      }
      for (let marker of markers) {
        marker.destroy()
      }
    } catch (e) {
      console.log(e)
    }
  }

  removeTempDir () {
    if (this.tempDir) {
      rimraf(this.tempDir, (e) => {
        if (e) {
          if (e.handle) {
            e.handle()
          }
          console.log(e)
        }
      })
      this.tempDir = null
    }
  }

  createCoverageFile () {
    this.removeTempDir()
    if (!this.tempDir) {
      this.tempDir = fs.realpathSync(temp.mkdirSync())
    }
    this.coverageFile = path.join(this.tempDir, 'coverage.out')
  }

  projectPath (editor) {
    if (editor && editor.getPath()) {
      return editor.getPath()
    }

    if (atom.project.getPaths().length) {
      return atom.project.getPaths()[0]
    }

    return false
  }

  getLocatorOptions (editor = this.getEditor()) {
    let options = {}
    let p = this.projectPath(editor)
    if (p) {
      options.directory = p
    }

    return options
  }

  getExecutorOptions (editor = this.getEditor()) {
    let o = this.getLocatorOptions(editor)
    let options = {}
    options.cwd = path.dirname(editor.getPath())
    let config = this.goconfig()
    if (config) {
      options.env = config.environment(o)
    }
    if (!options.env) {
      options.env = process.env
    }
    return options
  }

  ready () {
    return this.goconfig && this.goconfig()
  }

  runCoverage (editor = this.getEditor()) {
    if (!this.isValidEditor(editor)) {
      return Promise.resolve()
    }
    let buffer = editor.getBuffer()
    if (!buffer) {
      return Promise.resolve()
    }
    if (this.running) {
      return Promise.resolve()
    }

    return Promise.resolve().then(() => {
      this.running = true
      this.clearMarkersFromEditors()
      this.createCoverageFile()
      let config = this.goconfig()
      let go = false
      let cover = false
      let locatorOptions = this.getLocatorOptions(editor)
      return config.locator.findTool('go', locatorOptions).then((cmd) => {
        if (!cmd) {
          return false
        }
        go = cmd
        return config.locator.findTool('cover', locatorOptions)
      }).then((cmd) => {
        if (!cmd) {
          return false
        }
        cover = cmd
      }).then(() => {
        if (!go || !cover) {
          this.running = false
          return
        }

        let cmd = go
        let args = ['test', '-coverprofile=' + this.coverageFile]
        if (atom.config.get('tester-go.runCoverageWithShortFlag')) {
          args.push('-short')
        }
        let executorOptions = this.getExecutorOptions(editor)
        return config.executor.exec(cmd, args, executorOptions).then((r) => {
          if (r.stderr && r.stderr.trim() !== '') {
            console.log('tester-go: (stderr) ' + r.stderr)
          }

          if (r.exitcode === 0) {
            this.ranges = parser.ranges(this.coverageFile)
            this.addMarkersToEditors()
          }

          this.running = false
        })
      }).catch((e) => {
        if (e.handle) {
          e.handle()
        }
        console.log(e)
        this.running = false
        return Promise.resolve()
      })
    })
  }
}
export {Tester}
