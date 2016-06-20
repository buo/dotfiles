'use babel'
/* eslint-env jasmine */

import {isTruthy} from './../lib/check'
import {Executor} from './../lib/executor'
import pathhelper from './../lib/pathhelper'
import {Locator} from './../lib/locator'
import temp from 'temp'
import fs from 'fs-extra'
import os from 'os'
import path from 'path'

describe('Locator', () => {
  let env = null
  let environmentFn = null
  let executor = null
  let platform = null
  let arch = null
  let executableSuffix = null
  let pathkey = null
  let readyFn = null
  let locator = null

  beforeEach(() => {
    temp.track()
    env = Object.assign({}, process.env)
    if (isTruthy(env.GOROOT)) {
      delete env.GOROOT
    }
    environmentFn = () => {
      return env
    }
    readyFn = () => { return true }
    platform = process.platform
    if (process.arch === 'arm') {
      arch = 'arm'
    } else if (process.arch === 'ia32') {
      // Ugh, Atom is 32-bit on Windows... for now.
      if (platform === 'win32') {
        arch = 'amd64'
      } else {
        arch = '386'
      }
    } else {
      arch = 'amd64'
    }
    executor = new Executor({environmentFn: environmentFn})
    executableSuffix = ''
    pathkey = 'PATH'
    if (process.platform === 'win32') {
      platform = 'windows'
      executableSuffix = '.exe'
      pathkey = 'Path'
    }

    locator = new Locator({
      environment: environmentFn,
      executor: executor,
      ready: readyFn
    })
  })

  afterEach(() => {
    if (executor !== null) {
      executor.dispose()
      executor = null
    }

    if (locator !== null) {
      locator.dispose()
      locator = null
    }

    arch = null
    platform = null
    environmentFn = null
    executableSuffix = null
    pathkey = null
    readyFn = null
  })

  describe('when the environment is process.env', () => {
    it('findExecutablesInPath returns an empty array if its arguments are invalid', () => {
      expect(locator.findExecutablesInPath).toBeDefined()
      expect(locator.findExecutablesInPath(false, false).length).toBe(0)
      expect(locator.findExecutablesInPath('', false).length).toBe(0)
      expect(locator.findExecutablesInPath('abcd', false).length).toBe(0)
      expect(locator.findExecutablesInPath('abcd', {bleh: 'abcd'}).length).toBe(0)
      expect(locator.findExecutablesInPath('abcd', 'abcd').length).toBe(0)
      expect(locator.findExecutablesInPath('abcd', []).length).toBe(0)
      expect(locator.findExecutablesInPath([], []).length).toBe(0)
    })

    it('findExecutablesInPath returns an array with elements if its arguments are valid', () => {
      expect(locator.findExecutablesInPath).toBeDefined()
      if (os.platform() === 'win32') {
        expect(locator.findExecutablesInPath('c:\\windows\\system32', ['cmd.exe']).length).toBe(1)
        expect(locator.findExecutablesInPath('c:\\windows\\system32', ['cmd.exe'])[0]).toBe('c:\\windows\\system32\\cmd.exe')
      } else {
        expect(locator.findExecutablesInPath('/bin', ['sh']).length).toBe(1)
        expect(locator.findExecutablesInPath('/bin', ['sh'])[0]).toBe('/bin/sh')
      }
    })
  })

  describe('when the environment has a GOPATH that includes a tilde', () => {
    beforeEach(() => {
      env.GOPATH = path.join('~', 'go')
    })

    it('is defined', () => {
      expect(locator).toBeDefined()
      expect(locator).toBeTruthy()
    })

    it('gopath() returns a path with the home directory expanded', () => {
      expect(locator.gopath).toBeDefined()
      expect(locator.gopath()).toBe(path.join(pathhelper.home(), 'go'))
    })
  })

  describe('when the environment has an empty GOPATH', () => {
    beforeEach(() => {
      if (isTruthy(env.GOPATH)) {
        delete env.GOPATH
      }
    })

    it('gopath() returns false', () => {
      expect(locator.gopath).toBeDefined()
      expect(locator.gopath()).toBe(false)
    })
  })

  describe('when the environment has a GOPATH that is whitespace', () => {
    beforeEach(() => {
      env.GOPATH = '        '
    })

    it('gopath() returns false', () => {
      expect(locator.gopath).toBeDefined()
      expect(locator.gopath()).toBe(false)
    })
  })

  describe('when the PATH has a single directory with a go runtime in it', () => {
    let godir = null
    let go = null
    beforeEach(() => {
      godir = temp.mkdirSync('go-')
      go = path.join(godir, 'go' + executableSuffix)
      fs.writeFileSync(go, '.', {encoding: 'utf8', mode: 511})
      env[pathkey] = godir
      env.GOPATH = path.join('~', 'go')
    })

    it('runtimeCandidates() finds the runtime', () => {
      expect(locator.runtimeCandidates).toBeDefined()
      let candidates = locator.runtimeCandidates()
      expect(candidates).toBeTruthy()
      expect(candidates.length).toBeGreaterThan(0)
      expect(candidates[0]).toBe(go)
    })
  })

  describe('when GOROOT is set and the go tool is available within $GOROOT/bin', () => {
    let godir = null
    let go = null
    let gorootgo = null
    let gorootdir = null
    let gorootbindir = null

    beforeEach(() => {
      gorootdir = temp.mkdirSync('goroot-')
      gorootbindir = path.join(gorootdir, 'bin')
      fs.mkdirSync(gorootbindir)
      gorootgo = path.join(gorootbindir, 'go' + executableSuffix)
      godir = temp.mkdirSync('go-')
      go = path.join(godir, 'go' + executableSuffix)
      fs.writeFileSync(gorootgo, '.', {encoding: 'utf8', mode: 511})
      fs.writeFileSync(go, '.', {encoding: 'utf8', mode: 511})
      env[pathkey] = godir
      env.GOROOT = gorootdir
      env.GOPATH = path.join('~', 'go')
    })

    afterEach(() => {
      env.GOROOT = ''
    })

    it('runtimeCandidates() finds the runtime and orders the go in $GOROOT/bin before the go in PATH', () => {
      expect(locator.runtimeCandidates).toBeDefined()
      let candidates = locator.runtimeCandidates()
      expect(candidates).toBeTruthy()
      expect(candidates.length).toBeGreaterThan(0)
      expect(candidates[0]).toBe(gorootgo)
      expect(candidates[1]).toBe(go)
    })
  })

  describe('when the PATH has multiple directories with a go runtime in it', () => {
    let godir = null
    let go1dir = null
    let go = null
    let go1 = null
    beforeEach(() => {
      godir = temp.mkdirSync('go-')
      go1dir = temp.mkdirSync('go1-')
      go = path.join(godir, 'go' + executableSuffix)
      go1 = path.join(go1dir, 'go' + executableSuffix)
      fs.writeFileSync(go, '.', {encoding: 'utf8', mode: 511})
      fs.writeFileSync(go1, '.', {encoding: 'utf8', mode: 511})
      env[pathkey] = godir + path.delimiter + go1dir
    })

    it('runtimeCandidates() returns the candidates in the correct order', () => {
      expect(locator.runtimeCandidates).toBeDefined()
      let candidates = locator.runtimeCandidates()
      expect(candidates).toBeTruthy()
      expect(candidates.length).toBeGreaterThan(1)
      expect(candidates[0]).toBe(go)
      expect(candidates[1]).toBe(go1)
    })

    it('runtimeCandidates() returns candidates in the correct order when a candidate occurs multiple times in the path', () => {
      env[pathkey] = godir + path.delimiter + go1dir + path.delimiter + godir
      expect(locator.runtimeCandidates).toBeDefined()
      let candidates = locator.runtimeCandidates()
      expect(candidates).toBeTruthy()
      expect(candidates.length).toBeGreaterThan(1)
      expect(candidates[0]).toBe(go)
      expect(candidates[1]).toBe(go1)
      if (candidates.length > 2) {
        expect(candidates[2]).not.toBe(go)
      }
    })
  })

  describe('when the path includes a directory with go 1.5.1 in it', () => {
    let godir = null
    let gopathdir = null
    let gorootdir = null
    let gorootbindir = null
    let gotooldir = null
    let go = null
    let gorootbintools = null
    let gotooldirtools = null
    beforeEach(() => {
      gorootbintools = ['go', 'godoc', 'gofmt']
      gotooldirtools = ['addr2line', 'cgo', 'dist', 'link', 'pack', 'trace', 'api', 'compile', 'doc', 'nm', 'pprof', 'vet', 'asm', 'cover', 'fix', 'objdump', 'yacc']
      godir = temp.mkdirSync('go-')
      gopathdir = temp.mkdirSync('gopath-')
      gorootdir = temp.mkdirSync('goroot-')
      gorootbindir = path.join(gorootdir, 'bin')
      fs.mkdirSync(gorootbindir)
      gotooldir = path.join(gorootdir, 'pkg', 'tool', platform + '_' + arch)
      fs.mkdirsSync(gotooldir)
      let fakeexecutable = 'go_' + platform + '_' + arch + executableSuffix
      let go151json = path.join(__dirname, 'fixtures', 'go-151-' + platform + '.json')
      let fakego = path.join(__dirname, 'tools', 'go', fakeexecutable)
      go = path.join(gorootbindir, 'go' + executableSuffix)
      fs.copySync(fakego, go)
      fs.copySync(go151json, path.join(gorootbindir, 'go.json'))
      env[pathkey] = godir
      env['GOPATH'] = gopathdir
      env['GOROOT'] = gorootdir
      for (let tool of gorootbintools) {
        if (tool !== 'go') {
          fs.writeFileSync(path.join(gorootbindir, tool + executableSuffix), '.', {encoding: 'utf8', mode: 511})
        }
      }
      for (let tool of gotooldirtools) {
        let toolpath = path.join(gotooldir, tool + executableSuffix)
        fs.writeFileSync(toolpath, '.', {encoding: 'utf8', mode: 511})
      }
    })

    it('runtimeCandidates() finds the runtime', () => {
      expect(locator.runtimeCandidates).toBeDefined()
      let candidates = locator.runtimeCandidates()
      expect(candidates).toBeTruthy()
      expect(candidates.length).toBeGreaterThan(0)
      expect(candidates[0]).toBe(go)
    })

    it('runtimes() returns the runtime', () => {
      expect(locator.runtimes).toBeDefined()
      let runtimes = null
      let done = locator.runtimes().then((r) => { runtimes = r })

      waitsForPromise(() => { return done })

      runs(() => {
        expect(runtimes).toBeTruthy()
        expect(runtimes.length).toBeGreaterThan(0)
        expect(runtimes[0].name).toBe('go1.5.1')
        expect(runtimes[0].semver).toBe('1.5.1')
        expect(runtimes[0].version).toBe('go version go1.5.1 ' + platform + '/' + arch)
        expect(runtimes[0].path).toBe(go)
        expect(runtimes[0].GOARCH).toBe(arch)
        expect(runtimes[0].GOBIN).toBe('')
        if (platform === 'windows') {
          expect(runtimes[0].GOEXE).toBe('.exe')
        } else {
          expect(runtimes[0].GOEXE).toBe('')
        }
        expect(runtimes[0].GOHOSTARCH).toBe(arch)
        expect(runtimes[0].GOHOSTOS).toBe(platform)
        expect(runtimes[0].GOOS).toBe(platform)
        expect(runtimes[0].GOPATH).toBe(gopathdir)
        expect(runtimes[0].GORACE).toBe('')
        expect(runtimes[0].GOROOT).toBe(gorootdir)
        expect(runtimes[0].GOTOOLDIR).toBe(gotooldir)
        if (platform === 'windows') {
          expect(runtimes[0].CC).toBe('gcc')
          expect(runtimes[0].GOGCCFLAGS).toBe('-m64 -mthreads -fmessage-length=0')
          expect(runtimes[0].CXX).toBe('g++')
        } else if (platform === 'darwin') {
          expect(runtimes[0].CC).toBe('clang')
          expect(runtimes[0].GOGCCFLAGS).toBe('-fPIC -m64 -pthread -fno-caret-diagnostics -Qunused-arguments -fmessage-length=0 -fno-common')
          expect(runtimes[0].CXX).toBe('clang++')
        } else if (os.platform() === 'linux') {
          expect(runtimes[0].CC).toBe('gcc')
          expect(runtimes[0].GOGCCFLAGS).toBe('-fPIC -m64 -pthread -fmessage-length=0')
          expect(runtimes[0].CXX).toBe('g++')
        }
        expect(runtimes[0].GO15VENDOREXPERIMENT).toBe('')
        expect(runtimes[0].CGO_ENABLED).toBe('1')
      })
    })

    it('findTool() finds the go tool', () => {
      expect(locator.findTool).toBeDefined()
      let tool = null
      let err = null
      let done = locator.findTool('go').then((t) => { tool = t }).catch((e) => { err = e })

      waitsForPromise(() => { return done })

      runs(() => {
        expect(err).toBe(null)
        expect(tool).toBeTruthy()
        expect(tool).toBe(path.join(gorootbindir, 'go' + executableSuffix))
      })
    })

    it('findTool() finds tools in GOROOT', () => {
      let tools = ['go', 'godoc', 'gofmt']
      let runtime = false
      let tool = null
      let toolPath = false
      let done = locator.runtime().then((r) => { runtime = r })

      waitsForPromise(() => { return done })

      runs(() => {
        for (let toolItem of tools) {
          tool = null
          done = null
          toolPath = path.join(runtime.GOROOT, 'bin', toolItem + runtime.GOEXE)
          done = locator.findTool(toolItem).then((t) => { tool = t })
          waitsForPromise(() => { return done })

          runs(() => {
            expect(tool).toBeTruthy()
            expect(tool).toBe(toolPath)
          })
        }
      })
    })

    it('stat() returns false for nonexistent files', () => {
      let stat = null
      let done = locator.stat('nonexistentthing').then((s) => { stat = s })
      waitsForPromise(() => { return done })

      runs(() => {
        expect(stat).toBe(false)
      })
    })

    it('findTool() finds tools in GOTOOLDIR', () => {
      let tools = ['addr2line', 'cgo', 'dist', 'link', 'pack', 'trace', 'api', 'compile', 'doc', 'nm', 'pprof', 'vet', 'asm', 'cover', 'fix', 'objdump', 'yacc']
      let runtime = false
      let done = locator.runtime().then((r) => { runtime = r })

      waitsForPromise(() => { return done })

      runs(() => {
        for (let toolItem of tools) {
          let tool = null
          let toolPath = path.join(runtime.GOTOOLDIR, toolItem + runtime.GOEXE)
          let done = locator.findTool(toolItem).then((t) => { tool = t })
          waitsForPromise(() => { return done })

          runs(() => {
            expect(tool).toBeTruthy()
            expect(tool).toBe(toolPath)
          })
        }
      })
    })
  })

  describe('when the path includes a directory with the gometalinter tool in it', () => {
    let gopathdir = null
    let gopathbindir = null
    let pathdir = null
    let pathtools = null
    let gopathbintools = null
    beforeEach(() => {
      pathtools = ['gometalinter', 'gb']
      gopathbintools = ['somerandomtool', 'gb']
      pathdir = temp.mkdirSync('path-')
      gopathdir = temp.mkdirSync('gopath-')
      gopathbindir = path.join(gopathdir, 'bin')
      fs.mkdirSync(gopathbindir)
      env['GOPATH'] = gopathdir
      env[pathkey] = pathdir + path.delimiter + env['PATH']
      for (let tool of pathtools) {
        fs.writeFileSync(path.join(pathdir, tool + executableSuffix), '.', {encoding: 'utf8', mode: 511})
      }
      for (let tool of gopathbintools) {
        fs.writeFileSync(path.join(gopathbindir, tool + executableSuffix), '.', {encoding: 'utf8', mode: 511})
      }
    })

    it('findTool() finds tools in PATH', () => {
      runs(() => {
        for (let toolItem of pathtools) {
          let toolPath = false
          let tool = null
          let done = null

          if (gopathbintools.indexOf(toolItem) !== -1) {
            toolPath = path.join(gopathbindir, toolItem + executableSuffix)
          } else {
            toolPath = path.join(pathdir, toolItem + executableSuffix)
          }

          done = locator.findTool(toolItem).then((t) => {
            tool = t
          })
          waitsForPromise(() => { return done })
          runs(() => {
            done = null
            expect(tool).toBeTruthy()
            expect(tool).toBe(toolPath)
          })
        }
      })
    })

    it('findTool() finds tools in GOPATH\'s bin directory', () => {
      runs(() => {
        for (let toolItem of gopathbintools) {
          let tool = null
          let toolPath = false
          let done = null
          toolPath = path.join(gopathbindir, toolItem + executableSuffix)
          done = locator.findTool(toolItem).then((t) => { tool = t })
          waitsForPromise(() => { return done })
          runs(() => {
            expect(tool).toBeTruthy()
            expect(tool).toBe(toolPath)
          })
        }
      })
    })
  })
})
