'use babel'

import path from 'path'
import os from 'os'
import osHomedir from 'os-homedir'
import {isFalsy} from './check'

function expand (env, thepath) {
  if (isFalsy(thepath) || thepath.trim() === '') {
    return ''
  }

  if (isFalsy(env)) {
    return thepath
  }

  thepath = thepath.replace(/(~|\$[^\\/:]*|%[^\\;%]*%)+?/gim, (text, match) => {
    if (match === '~') {
      return home()
    } else {
      let m = match
      if (os.platform() === 'win32') {
        m = match.replace(/%/g, '')
      } else {
        m = match.replace(/\$/g, '')
      }

      if (typeof env[m] !== 'undefined') {
        if (m === 'GOPATH' && env[m].indexOf(path.delimiter) !== -1) {
          return expand(env, env[m].split(path.delimiter)[0].trim())
        } else {
          return expand(env, env[m])
        }
      } else {
        return match
      }
    }
  })

  if (thepath.indexOf(path.delimiter) === -1) {
    return resolveAndNormalize(thepath)
  }

  let paths = thepath.split(path.delimiter)
  let result = ''
  for (let pathItem of paths) {
    pathItem = resolveAndNormalize(pathItem)
    if (result === '') {
      result = pathItem
    } else {
      result = result + path.delimiter + pathItem
    }
  }

  return result
}

function resolveAndNormalize (pathitem) {
  if (isFalsy(pathitem) || pathitem.trim() === '') {
    return ''
  }
  let result = path.resolve(path.normalize(pathitem))
  return result
}

function home () {
  return osHomedir()
}

export default { expand, resolveAndNormalize, home }
