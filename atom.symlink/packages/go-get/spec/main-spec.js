'use babel'

describe('go-get', () => {
  let mainModule = null

  beforeEach(() => {
    waitsForPromise(() => {
      return atom.packages.activatePackage('go-config').then(() => {
        return atom.packages.activatePackage('go-get')
      }).then((pack) => {
        mainModule = pack.mainModule
      })
    })

    waitsFor(() => {
      return mainModule.getGoconfig()
    })
  })

  describe('when the go-get package is activated', () => {
    it('activates successfully', () => {
      expect(mainModule).toBeDefined()
      expect(mainModule).toBeTruthy()
      expect(mainModule.getProvider).toBeDefined()
      expect(mainModule.getGoconfig).toBeDefined()
      expect(mainModule.consumeGoconfig).toBeDefined()
      expect(mainModule.getGoconfig()).toBeTruthy()
      expect(mainModule.getProvider()).toBeTruthy()
      expect(mainModule.getProvider().get).toBeDefined()
      expect(mainModule.getProvider().check).toBeDefined()
    })
  })
})
