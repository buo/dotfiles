'use babel'

import {CompositeDisposable} from 'atom'
import fs from 'fs'
import path from 'path'
import rimraf from 'rimraf'
import temp from 'temp'

class Builder {
  constructor (goconfigFunc) {
    this.goconfig = goconfigFunc
    this.subscriptions = new CompositeDisposable()

    this.name = 'go build'
    this.grammarScopes = ['source.go']
    this.scope = 'project'
    this.lintOnFly = false
    temp.track()
  }

  dispose () {
    if (this.subscriptions) {
      this.subscriptions.dispose()
    }
    this.subscriptions = null
    this.goconfig = null
    this.name = null
    this.grammarScopes = null
    this.lintOnFly = null
  }

  ready () {
    if (!this.goconfig) {
      return false
    }
    let config = this.goconfig()
    if (!config) {
      return false
    }

    return true
  }

  lint (editor) {
    if (!this.ready() || !editor) {
      return []
    }
    let p = editor.getPath()
    if (!p) {
      return []
    }
    return Promise.resolve().then(() => {
      let cwd = path.dirname(p)
      let hasTests = false
      if (editor.getPath().endsWith('_test.go')) {
        hasTests = true
      } else {
        let files = fs.readdirSync(cwd)
        for (let file of files) {
          if (file.endsWith('_test.go')) {
            hasTests = true
          }
        }
      }

      let config = this.goconfig()
      let options = this.getLocatorOptions(editor)
      return config.locator.findTool('go', options).then((cmd) => {
        if (!cmd) {
          return []
        }

        let options = this.getExecutorOptions(editor)
        let buildArgs = ['install', '.']
        let buildPromise = config.executor.exec(cmd, buildArgs, options).then((r) => {
          if (r.stdout && r.stdout.trim() !== '') {
            console.log('builder-go: (stdout) ' + r.stdout)
          }
          let messages = []
          if (r.stderr && r.stderr.trim() !== '') {
            messages = this.mapMessages(r.stderr, options.cwd, 'build')
          }
          if (!messages || messages.length < 1) {
            return []
          }
          return messages
        }).catch((e) => {
          console.log(e)
          return []
        })

        if (!hasTests) {
          return buildPromise
        }

        let tempdir = fs.realpathSync(temp.mkdirSync())
        let testArgs = ['test', '-c', '-o', tempdir, '.']
        let testPromise = config.executor.exec(cmd, testArgs, options).then((r) => {
          if (r.stdout && r.stdout.trim() !== '') {
            console.log('builder-go: (stdout) ' + r.stdout)
          }
          let messages = []
          if (r.stderr && r.stderr.trim() !== '') {
            messages = this.mapMessages(r.stderr, options.cwd, 'test')
          }
          if (!messages || messages.length < 1) {
            return []
          }

          rimraf(tempdir, (e) => {
            if (e) {
              if (e.handle) {
                e.handle()
              }
              console.log(e)
            }
          })
          return messages
        }).catch((e) => {
          console.log(e)
          return []
        })

        return Promise.all([buildPromise, testPromise]).then((results) => {
          let messages = []
          for (let result of results) {
            if (result && result.length) {
              messages = messages.concat(result)
            }
          }
          return messages
        })
      })
    }).catch((error) => {
      if (error.handle) {
        error.handle()
      }
      console.log(error)
      return []
    })
  }

  getLocatorOptions (editor = atom.workspace.getActiveTextEditor()) {
    let options = {}
    if (editor) {
      options.file = editor.getPath()
      options.directory = path.dirname(editor.getPath())
    }
    if (!options.directory && atom.project.paths.length) {
      options.directory = atom.project.paths[0]
    }

    return options
  }

  getExecutorOptions (editor = atom.workspace.getActiveTextEditor()) {
    let o = this.getLocatorOptions(editor)
    let options = {}
    if (o.directory) {
      options.cwd = o.directory
    }
    let config = this.goconfig()
    if (config) {
      options.env = config.environment(o)
    }
    if (!options.env) {
      options.env = process.env
    }
    return options
  }

  mapMessages (data, cwd, linterName) {
    let pattern = /^((#)\s(.*)?)|((.*?):(\d*?):((\d*?):)?\s((.*)?((\n\t.*)+)?))/img
    let messages = []
    let extract = (matchLine) => {
      if (!matchLine) {
        return
      }
      if (matchLine[2] && matchLine[2] === '#') {
        // Found A Package Indicator, Skip For Now
      } else {
        let file
        if (matchLine[5] && matchLine[5] !== '') {
          if (path.isAbsolute(matchLine[5])) {
            file = matchLine[5]
          } else {
            file = path.join(cwd, matchLine[5])
          }
        }
        let row = matchLine[6]
        let column = matchLine[8]
        let text = matchLine[9]
        let range
        if (column && column >= 0) {
          range = [[row - 1, column - 1], [row - 1, 1000]]
        } else {
          range = [[row - 1, 0], [row - 1, 1000]]
        }
        messages.push({name: linterName, type: 'error', row: row, column: column, text: text + ' (' + linterName + ')', filePath: file, range: range})
      }
    }
    let match
    while ((match = pattern.exec(data)) !== null) {
      extract(match)
    }
    return messages
  }
}
export {Builder}
