module.exports =
	subs: null
	activate: ->
		# {name} = require './package.json' if @debug
		{exec} = require 'child_process' #,execSync}
#-------------------------------------------------------------------------------

		#console.log "#{name} package activated." if @debug

		@subs = atom.workspace.observeTextEditors (editor) ->
			scpt = editor.getPath()
			{scopeName} = editor.getGrammar()

			if scopeName.endsWith('applescript') and scpt?.endsWith '.scpt'

				# Decompile .scpt
				stdout = exec "osadecompile '#{scpt}'" #execSync
				stdout.stdout.on 'data', (data) -> editor.setText data #stdout.toString()
				#console.log "#{name}: Decompiled #{scpt}." if @debug

				# Recompile on save/close
				editor.onDidDestroy -> #onDidSave
					exec "osacompile -o '#{scpt}'{,}"
					#console.log "#{name}: Recompiled #{scpt}." if @debug

#-------------------------------------------------------------------------------
	deactivate: -> @subs.dispose()
