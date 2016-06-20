'use babel'

import {CompositeDisposable, Point} from 'atom'
import {NavigationStack} from './navigation-stack'
import path from 'path'
import fs from 'fs'

class Godef {
  constructor (goconfigFunc, gogetFunc) {
    this.goget = gogetFunc
    this.goconfig = goconfigFunc
    this.subscriptions = new CompositeDisposable()
    this.godefCommand = 'golang:godef'
    this.returnCommand = 'golang:godef-return'
    this.navigationStack = new NavigationStack()
    atom.commands.add('atom-workspace', 'golang:godef', () => {
      if (this.ready()) {
        this.gotoDefinitionForWordAtCursor()
      }
    })
    atom.commands.add('atom-workspace', 'golang:godef-return', () => {
      if (this.navigationStack) {
        this.navigationStack.restorePreviousLocation()
      }
    })
    this.cursorOnChangeSubscription = null
  }

  dispose () {
    if (this.subscriptions) {
      this.subscriptions.dispose()
    }
    this.subscriptions = null
    this.goget = null
    this.goconfig = null
    this.toolCheckComplete = null
  }

  ready () {
    if (!this.goconfig || !this.goconfig()) {
      return false
    }

    return true
  }

  clearReturnHistory () {
    this.navigationStack.reset()
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

  gotoDefinitionForWordAtCursor () {
    let editor = this.getEditor()
    if (!editor) {
      return Promise.resolve(false)
    }

    if (editor.hasMultipleCursors()) {
      atom.notifications.addWarning('navigator-godef', {
        dismissable: true,
        icon: 'location',
        detail: 'godef only works with a single cursor'
      })
      return Promise.resolve(false)
    }

    return Promise.resolve().then(() => {
      let editorCursorUTF8Offset = (e) => {
        let characterOffset = e.getBuffer().characterIndexForPosition(e.getCursorBufferPosition())
        let text = e.getText().substring(0, characterOffset)
        return Buffer.byteLength(text, 'utf8')
      }

      let offset = editorCursorUTF8Offset(editor)
      if (this.cursorOnChangeSubscription) {
        this.cursorOnChangeSubscription.dispose()
        this.cursorOnChangeSubscription = null
      }
      return this.gotoDefinitionWithParameters(['-o', offset, '-i'], editor.getText())
    })
  }

  gotoDefinitionForWord (word) {
    return this.gotoDefinitionWithParameters([word], undefined)
  }

  gotoDefinitionWithParameters (cmdArgs, cmdInput = undefined) {
    let editor = this.getEditor()
    let config = this.goconfig()
    return this.checkForTool(editor).then((cmd) => {
      if (!cmd) {
        return
      }

      let filepath = editor.getPath()
      let args = ['-f', filepath].concat(cmdArgs)
      let options = this.getExecutorOptions(editor)
      if (cmdInput) {
        options.input = cmdInput
      }
      return config.executor.exec(cmd, args, options).then((r) => {
        if (r.exitcode !== 0) {
          // TODO: Notification?
          return false
        }
        if (r.stderr && r.stderr.trim() !== '') {
          console.log('navigator-godef: (stderr) ' + r.stderr)
        }
        return this.visitLocation(this.parseGodefLocation(r.stdout))
      }).catch((e) => {
        console.log(e)
        return false
      })
    })
  }

  getLocatorOptions (editor = this.getEditor()) {
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

  getExecutorOptions (editor = this.getEditor()) {
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

  checkForTool (editor = this.getEditor()) {
    let config = this.goconfig()
    let options = this.getLocatorOptions(editor)
    return config.locator.findTool('godef', options).then((cmd) => {
      if (cmd) {
        return cmd
      }

      if (!cmd && !this.toolCheckComplete) {
        this.toolCheckComplete = true
        let goget = this.goget()
        if (!goget) {
          return false
        }
        goget.get({
          name: 'navigator-godef',
          packageName: 'godef',
          packagePath: 'github.com/rogpeppe/godef',
          type: 'missing'
        }).then((r) => {
          if (!r.success) {
            return false
          }
          return this.updateTools(editor)
        }).catch((e) => {
          console.log(e)
        })
      }

      return false
    })
  }

  parseGodefLocation (godefStdout) {
    let outputs = godefStdout.trim().split(':')
    let colNumber = 0
    let rowNumber = 0
    if (outputs.length > 1) {
      colNumber = outputs.pop()
      rowNumber = outputs.pop()
    }

    let targetFilePath = outputs.join(':')

    // godef on an import returns the imported package directory with no
    // row and column information: handle this appropriately
    if (targetFilePath.length === 0 && rowNumber) {
      targetFilePath = [rowNumber, colNumber].join(':')
      rowNumber = undefined
      colNumber = undefined
    }

    // atom's cursors are 0-based; godef uses diff-like 1-based
    let p = (rawPosition) => {
      return parseInt(rawPosition, 10) - 1
    }

    let result = {
      filepath: targetFilePath,
      raw: godefStdout
    }

    if (rowNumber && colNumber) {
      result.pos = new Point(p(rowNumber), p(colNumber))
    }
    return result
  }

  visitLocation (loc, callback) {
    if (!loc || !loc.filepath) {
      if (loc) {
        atom.notifications.addWarning('navigator-godef', {
          dismissable: true,
          icon: 'location',
          description: JSON.stringify(loc.raw),
          detail: 'godef returned malformed output'
        })
      } else {
        atom.notifications.addWarning('navigator-godef', {
          dismissable: true,
          icon: 'location',
          detail: 'godef returned malformed output'
        })
      }

      return false
    }

    return fs.stat(loc.filepath, (err, stats) => {
      if (err) {
        if (err.handle) {
          err.handle()
        }
        atom.notifications.addWarning('navigator-godef', {
          dismissable: true,
          icon: 'location',
          detail: 'godef returned invalid file path',
          description: loc.filepath
        })
        return false
      }

      this.navigationStack.pushCurrentLocation()
      if (stats.isDirectory()) {
        return this.visitDirectory(loc, callback)
      } else {
        return this.visitFile(loc, callback)
      }
    })
  }

  visitFile (loc, callback) {
    return atom.workspace.open(loc.filepath).then((editor) => {
      if (loc.pos) {
        editor.scrollToBufferPosition(loc.pos)
        editor.setCursorBufferPosition(loc.pos)
        this.cursorOnChangeSubscription = this.highlightWordAtCursor(editor)
      }
    })
  }

  visitDirectory (loc, callback) {
    return this.findFirstGoFile(loc.filepath).then((file) => {
      return this.visitFile({filepath: file, raw: loc.raw}, callback)
    }).catch((err) => {
      if (err.handle) {
        err.handle()
      }
      atom.notifications.addWarning('navigator-godef', {
        dismissable: true,
        icon: 'location',
        detail: 'godef return invalid directory',
        description: loc.filepath
      })
    })
  }

  findFirstGoFile (dir) {
    return new Promise((resolve, reject) => {
      fs.readdir(dir, (err, files) => {
        if (err) {
          reject(err)
        }

        let filepath = this.firstGoFilePath(dir, files.sort())
        if (filepath) {
          resolve(filepath)
        } else {
          reject(dir + 'has no non-test .go file')
        }
      })
    })
  }

  firstGoFilePath (dir, files) {
    for (let file of files) {
      if (file.endsWith('.go') && (file.indexOf('_test') === -1)) {
        return path.join(dir, file)
      }
    }

    return
  }

  wordAtCursor (editor = this.editor) {
    let options = {
      wordRegex: /[\w+\.]*/
    }

    let cursor = editor.getLastCursor()
    let range = cursor.getCurrentWordBufferRange(options)
    let word = editor.getTextInBufferRange(range)
    return {word: word, range: range}
  }

  highlightWordAtCursor (editor = this.editor) {
    let {range} = this.wordAtCursor(editor)
    let marker = editor.markBufferRange(range, {invalidate: 'inside'})
    editor.decorateMarker(marker, {type: 'highlight', class: 'definition'})
    let cursor = editor.getLastCursor()
    cursor.onDidChangePosition(() => {
      marker.destroy()
    })
  }
}

export {Godef}
