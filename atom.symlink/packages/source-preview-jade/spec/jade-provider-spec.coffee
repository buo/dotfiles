path = require 'path'
fs = require 'fs'
JadeProvider = require '../lib/jade-provider'

describe "JadeProvider", ->
  [provider] = []

  beforeEach ->
    provider = new JadeProvider

  describe "transform", ->
    it "jade -> html", ->
      jadeCode = fs.readFileSync(path.join(__dirname, 'fixtures', 'sample.jade'), encoding: 'utf8')
      htmlCode = fs.readFileSync(path.join(__dirname, 'fixtures', 'sample.html'), encoding: 'utf8')
      expect(provider.transform(jadeCode).code.trim()).toEqual(htmlCode.trim())

    it "jade -> html with extends", ->
      jadeFilePath = path.join(__dirname, 'fixtures', 'index.jade')
      jadeCode = fs.readFileSync(jadeFilePath, encoding: 'utf8')
      htmlCode = fs.readFileSync(path.join(__dirname, 'fixtures', 'index.html'), encoding: 'utf8')
      expect(provider.transform(jadeCode, filePath: jadeFilePath).code.trim()).toEqual(htmlCode.trim())
