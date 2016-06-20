{WorkspaceView} = require 'atom'
UrlEncode = require '../lib/url-encode'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "UrlEncode", ->
  [activationPromise, editor] = []

  beforeEach ->
    atom.workspaceView = new WorkspaceView

    waitsForPromise ->
      atom.workspaceView.open().then (ed) ->
        editor = ed

    activationPromise = atom.packages.activatePackage("url-encode")

  trigger = (t, cb) ->
    atom.workspaceView.trigger t
    waitsForPromise -> activationPromise
    runs ->
      cb()

  describe "url-encode:encode", ->
    it "still works even if the editor is not set", ->
      atom.workspaceView.destroyActivePaneItem()
      trigger 'url-encode:encode', ->
        expect(atom.workspaceView.getActiveView()).not.toBeDefined()

    it "does nothing when nothing is selected", ->
      editor.setText "text with spaces\nanother line with special chars%=!+"
      trigger 'url-encode:encode', ->
         expect(editor.getText()).
           toBe "text with spaces\nanother line with special chars%=!+"

    it "does encodes just the selected text", ->
      editor.setText "text with a lot of spaces\nanother line with special chars%=!+"
      editor.setSelectedBufferRange([[0,8], [0,16]])
      trigger 'url-encode:encode', ->
         expect(editor.getText()).
           toBe "text with%20a%20lot%20of spaces\nanother line with special chars%=!+"

    it "does encodes the multiple selected blocks of text", ->
      editor.setText "text with a lot of spaces\nanother line with special chars%=!+"
      editor.setSelectedBufferRanges([[[0,8], [0,16]], [[1,30], [1,35]]])
      trigger 'url-encode:encode', ->
         expect(editor.getText()).
           toBe "text with%20a%20lot%20of spaces\nanother line with special chars%25%3D!%2B"
