'use babel'

class NavigationStack {
  constructor (maxSize = 500) {
    if (maxSize >= 1) {
      this.maxSize = maxSize
    } else {
      this.maxSize = 1
    }
    this.stack = []
  }

  dispose () {
    this.maxSize = null
    this.stack = null
  }

  isEmpty () {
    return !this.stack || !this.stack.length || this.stack.length <= 0
  }

  reset () {
    this.stack = []
  }

  pushCurrentLocation () {
    let editor = atom.workspace.getActiveTextEditor()
    if (!editor) {
      return
    }
    let loc = {
      position: editor.getCursorBufferPosition(),
      file: editor.getURI()
    }

    if (!loc.file || !loc.position || !loc.position.row || !loc.position.column) {
      return
    }

    this.push(loc)
    return
  }

  // Returns a promise that is complete when navigation is done.
  restorePreviousLocation () {
    if (this.isEmpty()) {
      return Promise.resolve()
    }

    if (!this.stack || this.stack.length < 1) {
      return Promise.resolve()
    }

    let lastLocation = this.stack.shift()
    return atom.workspace.open(lastLocation.file).then((editor) => {
      this.moveEditorCursorTo(editor, lastLocation.position)
      return
    })
  }

  moveEditorCursorTo (editor, pos) {
    if (!editor) {
      return
    }
    editor.scrollToBufferPosition(pos)
    editor.setCursorBufferPosition(pos)
    return
  }

  push (loc) {
    if (!this.stack || !loc) {
      return
    }

    if (this.stack.length > 0 && this.compareLoc(this.stack[0], loc)) {
      return
    }
    this.stack.unshift(loc)
    if (this.stack.length > this.maxSize) {
      this.stack.splice(-1, this.stack.length - this.maxSize)
    }
    return
  }

  compareLoc (loc1, loc2) {
    if (!loc1 && !loc2) {
      return true
    }

    if (!loc1 || !loc2) {
      return false
    }

    return (loc1.filepath === loc2.filepath) && this.comparePosition(loc1.position, loc2.position)
  }

  comparePosition (pos1, pos2) {
    if (!pos1 && !pos2) {
      return true
    }

    if (!pos1 || !pos2) {
      return false
    }

    return ((pos1.column === pos2.column) && (pos1.row === pos2.row))
  }
}

export {NavigationStack}
