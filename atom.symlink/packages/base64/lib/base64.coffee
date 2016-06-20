module.exports =
  
  activate: (state) ->
    atom.commands.add 'atom-workspace',
      'base64:encode': => @encode()
      'base64:decode': => @decode()

  encode: ->
    editor = atom.workspace.getActiveTextEditor()
    selections = editor.getSelections()
    for selection in selections
      selection.insertText(
        new Buffer(selection.getText()).toString("base64"), 
        { "select": true}
      )

  decode: ->
    editor = atom.workspace.getActiveTextEditor()
    selections = editor.getSelections()
    for selection in selections
      selection.insertText(
        new Buffer(selection.getText(), "base64").toString("utf8"),
        { "select": true }
      )