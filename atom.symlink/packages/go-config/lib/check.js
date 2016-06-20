'use babel'

function isFalsy (value) {
  if (typeof value === 'undefined') {
    return true
  }
  if (value) {
    return false
  }
  return true
}

function isTruthy (value) {
  return !isFalsy(value)
}

function isArray (value) {
  if (isTruthy(value) && value.constructor === Array) {
    return true
  }

  return false
}

function isEmpty (value) {
  if (isTruthy(value) && value.constructor === Array && value.length < 1) {
    return true
  }

  return isFalsy(value)
}

export { isFalsy, isTruthy, isArray, isEmpty }
