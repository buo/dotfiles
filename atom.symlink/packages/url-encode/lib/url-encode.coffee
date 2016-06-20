module.exports =
  activate: (state) ->
    atom.commands.add 'atom-workspace',
      'url-encode:encode': => @transfromSel encodeURIComponent
      'url-encode:decode': => @transfromSel decodeURIComponent

  transfromSel: (t) ->
    editor = atom.workspace.getActiveTextEditor()
    if (editor?)
      selections = editor.getSelections()
      for sel in selections
        sel.insertText( t(sel.getText()), {"select": true} ) 
