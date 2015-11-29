'use babel'

import path from 'path'
import { resetConfig, lint } from './test-helper'
import LinterLessProvider from '../lib/linter-less-provider'

describe('Lint less', () => {
  beforeEach(() => {
    resetConfig()
    waitsForPromise(() => atom.packages.activatePackage('linter-less'))
  })

  describe('Unrecognised input', () => {

    it('retuns one error "Unrecognised input"', () => {
      waitsForPromise(() =>
        lint(path.join(__dirname, 'files', 'error-unrecognised-input.less'))
          .then((messages) => {
            expect(messages.length).toEqual(1)
            expect(messages[0].text).toEqual('Unrecognised input')
            expect(messages[0].range).toEqual([[0, 0], [0, 4]])
          })
      )
    })
  })

  describe('strict units', () => {

    it('retuns no errors', () => {
      waitsForPromise(() =>
        lint(path.join(__dirname, 'files', 'error-strict-units.less'))
          .then((messages) => expect(messages.length).toEqual(0))
      )
    })

    it('retuns one error "Incompatible units"', () => {
      atom.config.set('linter-less.strictUnits', true)
      waitsForPromise(() =>
        lint(path.join(__dirname, 'files', 'error-strict-units.less'))
          .then((messages) => {
            expect(messages.length).toEqual(1)
            expect(messages[0].text).toEqual(
              'Incompatible units. Change the units or use the unit function. Bad units: \'px\' and \'em\'.'
            )
            expect(messages[0].range).toEqual([[1, 2], [1, 20]])
          })
      )
    })
  })

  describe('undefined variable @fontSize', () => {

    it('retuns one error "variable @fontSize is undefined"', () => {
      waitsForPromise(() =>
        lint(path.join(__dirname, 'files', 'error-undefined-variable.less'))
          .then((messages) => {
            expect(messages.length).toEqual(1)
            expect(messages[0].text).toEqual('variable @fontSize is undefined')
            expect(messages[0].range).toEqual([[3, 13], [3, 22]])
          })

      )
    })

    it('ignores undefined variables', () => {
      atom.config.set('linter-less.ignoreUndefinedVariables', true)
      waitsForPromise(() =>
        lint(path.join(__dirname, 'files', 'error-undefined-variable.less'))
          .then((messages) => expect(messages.length).toEqual(0))
      )
    })

    it('ignores undefined global variables', () => {
      atom.config.set('linter-less.ignoreUndefinedGlobalVariables', true)
      waitsForPromise(() =>
        lint(path.join(__dirname, 'files', 'error-undefined-variable.less'))
          .then((messages) => expect(messages.length).toEqual(0))
      )
    })

    it('return error "\'<file>\' was not found"', () => {
      atom.config.set('linter-less.ignoreUndefinedGlobalVariables', true)
      waitsForPromise(() =>
        lint(path.join(__dirname, 'files', 'import-missing.less'))
          .then((messages) => {
            expect(messages.length).toEqual(1)
            expect(messages[0].text.replace(/(Tried -) .*$/, '$1 <paths>'))
              .toEqual('\'./icons.css\' wasn\'t found. Tried - <paths>')
          })
      )
    })

    it('should handle relative imports', () => {
      atom.config.set('linter-less.ignoreUndefinedGlobalVariables', true)
      waitsForPromise(() =>
        lint(path.join(__dirname, 'files', 'success-import.less'))
          .then((messages) => expect(messages.length).toEqual(0))
      )
    })
  })

  describe('Unrecognised input', () => {

    it('retuns one error "Unrecognised input"', () => {
      waitsForPromise(() =>
        lint(path.join(__dirname, 'files', 'rc', 'test.less'))
          .then((messages) => {
            // expect(messages.length).toEqual(1)
            // expect(messages[0].text).toEqual('Unrecognised input')
            // expect(messages[0].range).toEqual([[0, 0], [0, 4]])
          })
      )
    })
  })
})
