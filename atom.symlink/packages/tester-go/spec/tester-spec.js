'use babel'
/* eslint-env jasmine */

import path from 'path'
import temp from 'temp'
import fs from 'fs-plus'

describe('tester', () => {
  let mainModule = null
  let gopath = null
  let oldGopath = null

  beforeEach(() => {
    runs(() => {
      if (process.env.GOPATH) {
        oldGopath = process.env.GOPATH
      }
      gopath = temp.mkdirSync()
      process.env.GOPATH = gopath
      atom.project.setPaths(gopath)
    })

    waitsForPromise(() => {
      return atom.packages.activatePackage('go-config').then(() => {
        return atom.packages.activatePackage('tester-go')
      }).then((pack) => {
        mainModule = pack.mainModule
        return atom.packages.activatePackage('language-go')
      })
    })

    waitsFor(() => {
      return mainModule.getGoconfig() !== false
    })
  })

  afterEach(() => {
    if (oldGopath) {
      process.env.GOPATH = oldGopath
    } else {
      delete process.env.GOPATH
    }
  })

  describe('when run coverage on save is disabled', () => {
    let filePath
    let testFilePath
    let editor
    let testEditor

    beforeEach(() => {
      atom.config.set('tester-go.runCoverageOnSave', false)
      filePath = path.join(gopath, 'src', 'github.com', 'testuser', 'example', 'go-plus.go')
      testFilePath = path.join(gopath, 'src', 'github.com', 'testuser', 'example', 'go-plus_test.go')
      fs.writeFileSync(filePath, '')
      fs.writeFileSync(testFilePath, '')
      waitsForPromise(() => {
        return atom.workspace.open(filePath).then((e) => {
          editor = e
        })
      })

      waitsForPromise(() => {
        return atom.workspace.open(testFilePath).then((e) => {
          testEditor = e
        })
      })
    })

    it('displays coverage for go source', () => {
      let buffer = editor.getBuffer()
      buffer.setText('package main\n\nimport "fmt"\n\nfunc main()  {\n\tfmt.Println(Hello())\n}\n\nfunc Hello() string {\n\treturn "Hello, 世界"\n}\n')
      buffer.save()
      let testBuffer = testEditor.getBuffer()
      testBuffer.setText('package main\n\nimport "testing"\n\nfunc TestHello(t *testing.T) {\n\tresult := Hello()\n\tif result != "Hello, 世界" {\n\t\tt.Errorf("Expected %s - got %s", "Hello, 世界", result)\n\t}\n}')
      testBuffer.save()
      let p = mainModule.getTester().runCoverage(editor)

      waitsForPromise(() => { return p })

      runs(() => {
        let markers = buffer.findMarkers({class: 'gocover'})
        expect(markers).toBeDefined()
        expect(markers.length).toBe(2)
        expect(markers[0]).toBeDefined()
        let range = markers[0].getRange()
        expect(range.start.row).toBe(4)
        expect(range.start.column).toBe(13)
        expect(range.end.row).toBe(6)
        expect(range.end.column).toBe(1)

        expect(markers[1]).toBeDefined()
        range = markers[1].getRange()
        expect(range).toBeDefined()
        expect(range.start.row).toBe(8)
        expect(range.start.column).toBe(20)
        expect(range.end.row).toBe(10)
        expect(range.end.column).toBe(1)
      })
      expect(mainModule).toBeDefined()
      expect(mainModule).toBeTruthy()
      expect(mainModule.getGoconfig).toBeDefined()
      expect(mainModule.consumeGoconfig).toBeDefined()
      expect(mainModule.getGoconfig()).toBeTruthy()
      expect(mainModule.tester).toBeDefined()
      expect(mainModule.tester).toBeTruthy()
    })
  })
})
