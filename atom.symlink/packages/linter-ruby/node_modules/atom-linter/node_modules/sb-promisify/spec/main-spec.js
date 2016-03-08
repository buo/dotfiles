'use babel'

import promisify from '..'

describe('Promisify', function() {
  it('succeeds properly', function() {
    const callback = function(arg1, arg2) {
      expect(arg1).toBe('something')
      arg2(null, 'wow')
    }
    waitsForPromise(function() {
      return promisify(callback)('something').then(function(retVal) {
        expect(retVal).toBe(retVal)
      })
    })
  })

  it('throws properly', function() {
    const callback = function(arg1, arg2) {
      expect(arg1).toBe('something')
      arg2('wow')
    }
    waitsForPromise(function() {
      return promisify(callback)('something').then(function() {
        expect(false).toBe(true)
      }, function(error) {
        expect(error).toBe('wow')
      })
    })
  })
  it('works when Array.from is available', function() {
    const _ = Array.from
    Array.from = function(array) {
      return Array.prototype.slice.call(array)
    }
    const callback = function(arg1, arg2) {
      expect(arg1).toBe('something')
      arg2(null, 'wow')
    }
    waitsForPromise(function() {
      return promisify(callback)('something').then(function(retVal) {
        expect(retVal).toBe(retVal)
        Array.from = _
      })
    })
  })
  it('works when Array.from is not available', function() {
    const _ = Array.from
    Array.from = null
    const callback = function(arg1, arg2) {
      expect(arg1).toBe('something')
      arg2(null, 'wow')
    }
    waitsForPromise(function() {
      return promisify(callback)('something').then(function(retVal) {
        expect(retVal).toBe(retVal)
        Array.from = _
      })
    })
  })
})
