{Range} = require 'atom'

# With cursor at X, the command should select the string:
# "Here is the X cursor"
#
# With cursor at X, the command should select the single quoted string:
# "Here is 'the X cursor' now"
#
# This one doesn't work right yet. We're assuming that the first quote is
# the one we want, which isn't always true.
# With cursor at X, the command should select the double quoted string:
# "Here the cursor is 'outside' the X selection"

class ExpandSelectionToQuotes
  constructor: (@editor) ->
    @cursors = editor.getCursorBufferPositions()
    for b, index in @cursors
      @addSelection(index)

  getCursorPosition: (index) ->
    return @cursors[index]
    
  addSelection: (index) ->
    quoteRange = @getQuoteRange(index)
    @editor.addSelectionForBufferRange(quoteRange) if quoteRange

  getOpeningQuotePosition: (index) ->
    range = new Range @editor.buffer.getFirstPosition(), @getCursorPosition(index)
    quote = false
    @editor.buffer.backwardsScanInRange /[`|'|"]/g, range, (obj) =>
      @quoteType = obj.matchText
      obj.stop()
      quote = obj.range.end
    quote

  getClosingQuotePosition: (index) ->
    range = new Range @getCursorPosition(index), @editor.buffer.getEndPosition()
    quote = false
    @editor.buffer.scanInRange /[`|'|"]/g, range, (obj) =>
      obj.stop() if obj.matchText is @quoteType
      quote = obj.range.start
    quote

  getQuoteRange: (index) ->
    opening = @getOpeningQuotePosition(index)
    return false unless opening?
    closing = @getClosingQuotePosition(index)
    return false unless closing?
    new Range opening, closing

module.exports =
  activate: ->
    atom.commands.add 'atom-text-editor', 'expand-selection-to-quotes:toggle', ->
      paneItem = atom.workspace.getActivePaneItem()
      new ExpandSelectionToQuotes(paneItem)

  ExpandSelectionToQuotes: ExpandSelectionToQuotes
