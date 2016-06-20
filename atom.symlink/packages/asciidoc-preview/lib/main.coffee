url = require 'url'
fs = require 'fs-plus'

AsciiDocPreviewView = null
renderer = null # Defer until used

isAsciiDocPreviewView = (object) ->
  AsciiDocPreviewView ?= require './asciidoc-preview-view'
  object instanceof AsciiDocPreviewView

module.exports =

  activate: ->
    if parseFloat(atom.getVersion()) < 1.7
      atom.deserializers.add
        name: 'AsciiDocPreviewView'
        deserialize: module.exports.createAsciiDocPreviewView.bind(module.exports)

    atom.commands.add 'atom-workspace',
      'asciidoc-preview:toggle': =>
        @toggle()
      'asciidoc-preview:copy-html': =>
        @copyHtml()
      'asciidoc-preview:toggle-show-title': ->
        keyPath = 'asciidoc-preview.showTitle'
        atom.config.set(keyPath, not atom.config.get(keyPath))
      'asciidoc-preview:toggle-compat-mode': ->
        keyPath = 'asciidoc-preview.compatMode'
        atom.config.set(keyPath, not atom.config.get(keyPath))
      'asciidoc-preview:set-toc-none': ->
        atom.config.set('asciidoc-preview.tocType', 'none')
      'asciidoc-preview:set-toc-preamble': ->
        atom.config.set('asciidoc-preview.tocType', 'preamble')
      'asciidoc-preview:set-toc-macro': ->
        atom.config.set('asciidoc-preview.tocType', 'macro')
      'asciidoc-preview:set-section-numbering-enabled-by-default': ->
        atom.config.set('asciidoc-preview.sectionNumbering', 'enabled-by-default')
      'asciidoc-preview:set-section-numbering-always-enabled': ->
        atom.config.set('asciidoc-preview.sectionNumbering', 'always-enabled')
      'asciidoc-preview:set-section-numbering-always-disabled': ->
        atom.config.set('asciidoc-preview.sectionNumbering', 'always-disabled')
      'asciidoc-preview:set-section-numbering-not-specified': ->
        atom.config.set('asciidoc-preview.sectionNumbering', 'not-specified')
      'asciidoc-preview:toggle-skip-front-matter': ->
        keyPath = 'asciidoc-preview.skipFrontMatter'
        atom.config.set(keyPath, not atom.config.get(keyPath))
      'asciidoc-preview:toggle-render-on-save-only': ->
        keyPath = 'asciidoc-preview.renderOnSaveOnly'
        atom.config.set(keyPath, not atom.config.get(keyPath))

    previewFile = @previewFile.bind(this)
    atom.commands.add '.tree-view .file .name[data-name$=\\.adoc]', 'asciidoc-preview:preview-file', previewFile
    atom.commands.add '.tree-view .file .name[data-name$=\\.asciidoc]', 'asciidoc-preview:preview-file', previewFile
    atom.commands.add '.tree-view .file .name[data-name$=\\.ad]', 'asciidoc-preview:preview-file', previewFile
    atom.commands.add '.tree-view .file .name[data-name$=\\.asc]', 'asciidoc-preview:preview-file', previewFile
    atom.commands.add '.tree-view .file .name[data-name$=\\.adoc\\.txt]', 'asciidoc-preview:preview-file', previewFile
    atom.commands.add '.tree-view .file .name[data-name$=\\.txt]', 'asciidoc-preview:preview-file', previewFile

    atom.workspace.addOpener (uriToOpen) =>
      try
        {protocol, host, pathname} = url.parse(uriToOpen)
      catch error
        return

      return unless protocol is 'asciidoc-preview:'

      try
        pathname = decodeURI(pathname) if pathname
      catch error
        return

      if host is 'editor'
        @createAsciiDocPreviewView(editorId: pathname.substring(1))
      else
        @createAsciiDocPreviewView(filePath: pathname)

  createAsciiDocPreviewView: (state) ->
    if state.editorId or fs.isFileSync(state.filePath)
      AsciiDocPreviewView ?= require './asciidoc-preview-view'
      new AsciiDocPreviewView(state)

  toggle: ->
    if isAsciiDocPreviewView(atom.workspace.getActivePaneItem())
      atom.workspace.destroyActivePaneItem()
      return

    editor = atom.workspace.getActiveTextEditor()
    return unless editor?

    grammars = atom.config.get('asciidoc-preview.grammars') ? []
    return unless editor.getGrammar().scopeName in grammars

    @addPreviewForEditor(editor) unless @removePreviewForEditor(editor)

  uriForEditor: (editor) ->
    "asciidoc-preview://editor/#{editor.id}"

  removePreviewForEditor: (editor) ->
    uri = @uriForEditor(editor)
    previewPane = atom.workspace.paneForURI(uri)
    if previewPane?
      previewPane.destroyItem(previewPane.itemForURI(uri))
      true
    else
      false

  addPreviewForEditor: (editor) ->
    uri = @uriForEditor(editor)
    previousActivePane = atom.workspace.getActivePane()
    options =
      searchAllPanes: true
      split: atom.config.get 'asciidoc-preview.openInPane'

    atom.workspace.open(uri, options).then (markdownPreviewView) ->
      if isAsciiDocPreviewView(markdownPreviewView)
        previousActivePane.activate()

  previewFile: ({target}) ->
    filePath = target.dataset.path
    return unless filePath

    for editor in atom.workspace.getTextEditors() when editor.getPath() is filePath
      @addPreviewForEditor(editor)
      return

    atom.workspace.open "asciidoc-preview://#{encodeURI(filePath)}", searchAllPanes: true

  copyHtml: ->
    editor = atom.workspace.getActiveTextEditor()
    return unless editor?

    renderer ?= require './renderer'
    text = editor.getSelectedText() or editor.getText()
    renderer.toText text, editor.getPath(), (error, html) ->
      if error
        console.warn 'Copying AsciiDoc as HTML failed', error
      else
        atom.clipboard.write(html)
