"use babel"

import fs from "fs"
import path from "path"
import less from 'less'

const EXP_VARIABLE = /@[a-zA-Z0-9_-]+/
const EXP_VARIABLE_ALL = new RegExp(EXP_VARIABLE.source, 'g')
const EXP_GLOBAL_VARIABLE_ALL = /(^|\n)\/\/\s*global:\s*@[a-zA-Z0-9_-]+/g
const EXP_MIXIN = /([.#][a-zA-Z0-9_-]+)\s*(\(([^)]*)\))?;/
const EXP_MIXIN_ALL = new RegExp(EXP_MIXIN.source, 'g')

LinterLess = {

  name: "Less",

  grammarScopes: ['source.css.less'],

  scope: 'file',

  lintOnFly: true,

  lint(textEditor) {

    return new Promise((resolve, reject) => {

      const filePath = textEditor.getPath()
      if (!filePath) { return resolve([]) }

      let text = textEditor.getText()
      let lineOffset = 0

      if (this.config('ignoreUndefinedMixins')) {
        for (let mixin of (text.match(EXP_MIXIN_ALL) || [])) {
          lineOffset++
          mixinMatch = mixin.match(EXP_MIXIN)
          mixin = mixinMatch[1]
          args = ''
          if (mixinMatch[3]) {
            args = mixinMatch[3].split(',').map((v) => `@a`).join(';')
          }
          text = `${mixin}(${args}) {}\n${text}`
        }
      }

      if (this.config('ignoreUndefinedVariables')) {
        for (let variable of (text.match(EXP_VARIABLE_ALL) || [])) {
          lineOffset++
          text = `${variable}: 0;\n${text}`
        }
      }

      if (this.config('ignoreUndefinedGlobalVariables')) {
        for (line of (text.match(EXP_GLOBAL_VARIABLE_ALL) || [])) {
          let variable = text.match(EXP_VARIABLE)
          lineOffset++
          text = `${variable}: 0;\n${text}`
        }
      }

      this.lessParse(text, filePath, (err) => {

        if (!err) { return resolve([]) }

        let colEndIdx = 0
        let lineIdx = err.line - 1 - lineOffset
        let line = textEditor.lineTextForBufferRow(lineIdx)

        if (line) { colEndIdx = line.length }

        resolve([{
          type: "Error",
          text: err.message,
          filePath: err.filename,
          range: [[lineIdx, err.column], [lineIdx, colEndIdx]]
        }])
      })
    })
  },

  lessParse(text, filePath, callback) {

    this.getOptions(filePath)
      .then((options) => {
        less.render(text, options, (error, output) => callback(error))
      })
  },

  config(key) {
    return atom.config.get(`linter-less.${key}`)
  },

  option(rc, key, confKey = null) {
    confKey = confKey || key

    if (rc[key] !== undefined) {
      return rc[key]
    }
    return this.config(confKey)
  },

  getOptions(filePath) {
    return this.getRcContent(filePath)
      .then((rc) => {

        const cwd = path.dirname(filePath)

        const options = {
          verbose: false,
          silent: true,
          paths: [cwd, ...this.config('includePath'), ...(rc.paths || [])],
          filename: filePath,
          ieCompat: this.option(rc, 'ieCompat', 'ieCompatibilityChecks'),
          strictUnits: this.option(rc, 'strictUnits')
        }

        return options
      })
  },

  getRcContent(filePath) {

    return new Promise((resolve, reject) => {

      if (this.config('ignoreLessrc')) {
        return resolve({})
      }

      const rcPath = this.getRcPath(filePath)

      if (!rcPath) { return resolve({}) }

      const dirPath = path.dirname(rcPath)

      fs.readFile(rcPath, 'utf8', function (err, data) {
        if (err) { return reject(err) }

        try {
          const rc = JSON.parse(data)
          rc.paths = (rc.paths || []).map((p) => path.resolve(dirPath, p))
          resolve(rc)

        } catch(ex) {
          resolve({})
        }
      })
    })
  },

  getRcPath(currentPath) {

    let lastPath
    while (currentPath && lastPath !== currentPath) {
      lastPath = currentPath
      currentPath = path.dirname(currentPath)

      let rcPath = path.join(currentPath, '.lessrc')

      if (fs.existsSync(rcPath)) {
        return rcPath
      }
    }

    return null
  }
}

export default LinterLess
