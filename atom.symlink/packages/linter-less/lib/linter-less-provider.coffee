fs = require "fs"
path = require "path"
less = require 'less'

LinterLess =

  name: "Less"

  grammarScopes: ['source.css.less']

  scope: 'file'

  lintOnFly: true

  lint: (textEditor) ->

    return new Promise (resolve, reject) =>

      filePath = textEditor.getPath()
      return resolve([]) unless filePath

      text = textEditor.getText()

      lineOffset = 0
      variables = []

      if @config 'ignoreUndefinedVariables'
        for variable in (text.match(/@[a-zA-Z0-9_-]+/g) or [])
          lineOffset++
          text = "#{variable}: 0;\n#{text}"

      if @config 'ignoreUndefinedGlobalVariables'
        for line in (text.match(/(^|\n)\/\/\s*global:\s*@[a-zA-Z0-9_-]+/g) or [])
          variable = text.match(/@[a-zA-Z0-9_-]+/)
          lineOffset++
          text = "#{variable}: 0;\n#{text}"

      @lessParse text, filePath, (err) ->

        return resolve([]) unless err

        lineIdx = err.line - 1 - lineOffset
        line = textEditor.lineTextForBufferRow(lineIdx)
        colEndIdx = line.length if line

        resolve([
          type: "Error"
          text: err.message
          filePath: err.filename
          range: [[lineIdx, err.column], [lineIdx, colEndIdx]]
        ])


  lessParse: (text, filePath, callback) ->

    cwd = path.dirname filePath

    options =
      verbose: false
      silent: true
      paths: [cwd, @config('includePath')...]
      filename: filePath
      ieCompat: @config 'ieCompatibilityChecks'
      strictUnits: @config 'strictUnits'
      strictMath: @config 'strictMath'

    less.render text, options, (error, output) ->
      callback error

  config: (key) ->
    atom.config.get "linter-less.#{key}"

module.exports = LinterLess
