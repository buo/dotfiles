module.exports = GfmLists =
  activate: (state) ->
    atom.workspace.observeTextEditors (editor) ->
      if editor.getGrammar().name == "GitHub Markdown"
        editor.onDidInsertText (event) ->
          if event.text == "\n"
            previous_row_number = event.range.start.row
            console.log(previous_row_number)
            previous_row_range = editor.buffer.rangeForRow(previous_row_number)
            console.log(previous_row_range)
            previous_line = editor.getTextInRange(previous_row_range)
            console.log(previous_line)
            match = previous_line.match(/^\s*([\-|\*]\s\[[x|\s]\]|\*|\-|\d\.)\s.+/)
            console.log(match)
            if match
              switch match[1]
                when "*"     then editor.insertText "* "
                when "-"     then editor.insertText "- "
                when "- [ ]" then editor.insertText "- [ ] "
                when "* [ ]" then editor.insertText "* [ ] "
                when "- [x]" then editor.insertText "- [ ] "
                when "* [x]" then editor.insertText "* [ ] "
                else editor.insertText "#{parseInt(match[1]) + 1}. "
