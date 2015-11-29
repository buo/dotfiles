ColorScanner = require '../lib/color-scanner'
ColorContext = require '../lib/color-context'
registry = require '../lib/color-expressions'

describe 'ColorScanner', ->
  [scanner, editor, text, result, lastIndex] = []

  withTextEditor = (fixture, block) ->
    describe "with #{fixture} buffer", ->
      beforeEach ->
        waitsForPromise -> atom.workspace.open(fixture)
        runs ->
          editor = atom.workspace.getActiveTextEditor()
          text = editor.getText()

      afterEach -> editor = null

      do block

  withScannerForTextEditor = (fixture, block) ->
    withTextEditor fixture, ->
      beforeEach ->
        context = new ColorContext({registry})
        scanner = new ColorScanner({context})

      afterEach -> scanner = null

      do block

  describe '::search', ->
    withScannerForTextEditor 'html-entities.html', ->
      beforeEach ->
        result = scanner.search(text, 'html')

      it 'returns nothing', ->
        expect(result).toBeUndefined()

    withScannerForTextEditor 'css-color-with-prefix.less', ->
      beforeEach ->
        result = scanner.search(text, 'less')

      it 'returns nothing', ->
        expect(result).toBeUndefined()

    withScannerForTextEditor 'four-variables.styl', ->
      beforeEach ->
        result = scanner.search(text, 'styl')

      it 'returns the first buffer color match', ->
        expect(result).toBeDefined()

      describe 'the resulting buffer color', ->
        it 'has a text range', ->
          expect(result.range).toEqual([13,17])

        it 'has a color', ->
          expect(result.color).toBeColor('#ffffff')

        it 'stores the matched text', ->
          expect(result.match).toEqual('#fff')

        it 'stores the last index', ->
          expect(result.lastIndex).toEqual(17)

        it 'stores match line', ->
          expect(result.line).toEqual(0)

      describe 'successive searches', ->
        it 'returns a buffer color for each match and then undefined', ->
          doSearch = -> result = scanner.search(text, 'styl', result.lastIndex)

          expect(doSearch()).toBeDefined()
          expect(doSearch()).toBeDefined()
          expect(doSearch()).toBeDefined()
          expect(doSearch()).toBeUndefined()

        it 'stores the line of successive matches', ->
          doSearch = -> result = scanner.search(text, 'styl', result.lastIndex)

          expect(doSearch().line).toEqual(2)
          expect(doSearch().line).toEqual(4)
          expect(doSearch().line).toEqual(6)

      withScannerForTextEditor 'class-after-color.sass', ->
        beforeEach ->
          result = scanner.search(text, 'sass')

        it 'returns the first buffer color match', ->
          expect(result).toBeDefined()

        describe 'the resulting buffer color', ->
          it 'has a text range', ->
            expect(result.range).toEqual([15,20])

          it 'has a color', ->
            expect(result.color).toBeColor('#ffffff')

      withScannerForTextEditor 'project/styles/variables.styl', ->
        beforeEach ->
          result = scanner.search(text, 'styl')

        it 'returns the first buffer color match', ->
          expect(result).toBeDefined()

        describe 'the resulting buffer color', ->
          it 'has a text range', ->
            expect(result.range).toEqual([18,25])

          it 'has a color', ->
            expect(result.color).toBeColor('#BF616A')
