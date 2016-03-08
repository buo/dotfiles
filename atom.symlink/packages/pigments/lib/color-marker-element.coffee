{CompositeDisposable, Emitter} = require 'atom'
{registerOrUpdateElement, EventsDelegation} = require 'atom-utils'

SPEC_MODE = atom.inSpecMode()
RENDERERS =
  'background': require './renderers/background'
  'outline': require './renderers/outline'
  'underline': require './renderers/underline'
  'dot': require './renderers/dot'
  'square-dot': require './renderers/square-dot'

class ColorMarkerElement extends HTMLElement
  EventsDelegation.includeInto(this)

  renderer: new RENDERERS.background

  createdCallback: ->
    @emitter = new Emitter
    @released = true

  attachedCallback: ->

  detachedCallback: ->

  onDidRelease: (callback) ->
    @emitter.on 'did-release', callback

  setContainer: (@bufferElement) ->

  getModel: -> @colorMarker

  setModel: (@colorMarker) ->
    return unless @released
    @released = false
    @subscriptions = new CompositeDisposable
    @subscriptions.add @colorMarker.marker.onDidDestroy => @release()
    @subscriptions.add @colorMarker.marker.onDidChange (data) =>
      {isValid} = data
      if isValid then @bufferElement.requestMarkerUpdate([this]) else @release()

    @subscriptions.add atom.config.observe 'pigments.markerType', (type) =>
      @bufferElement.requestMarkerUpdate([this]) unless type is 'gutter'

    @subscriptions.add @subscribeTo this,
      click: (e) =>
        colorBuffer = @colorMarker.colorBuffer

        return unless colorBuffer?

        colorBuffer.selectColorMarkerAndOpenPicker(@colorMarker)

    @render()

  destroy: ->
    @parentNode?.removeChild(this)
    @subscriptions?.dispose()
    @clear()

  render: ->
    return unless @colorMarker? and @colorMarker.color?
    return if @colorMarker.marker.displayBuffer.isDestroyed()
    @innerHTML = ''
    {style, regions, class: cls} = @renderer.render(@colorMarker)

    regions = (regions or []).filter (r) -> r?

    if regions?.some((r) -> r?.invalid) and !SPEC_MODE
      return @bufferElement.requestMarkerUpdate([this])

    @appendChild(region) for region in regions
    if cls?
      @className = cls
    else
      @className = ''

    if style?
      @style[k] = v for k,v of style
    else
      @style.cssText = ''

    @lastMarkerScreenRange = @colorMarker.getScreenRange()

  checkScreenRange: ->
    return unless @colorMarker? and @lastMarkerScreenRange?
    unless @lastMarkerScreenRange.isEqual(@colorMarker.getScreenRange())
      @render()

  isReleased: -> @released

  release: (dispatchEvent=true) ->
    return if @released
    @subscriptions.dispose()
    marker = @colorMarker
    @clear()
    @emitter.emit('did-release', {marker, view: this}) if dispatchEvent

  clear: ->
    @subscriptions = null
    @colorMarker = null
    @released = true
    @innerHTML = ''
    @className = ''
    @style.cssText = ''

module.exports =
ColorMarkerElement =
registerOrUpdateElement 'pigments-color-marker', ColorMarkerElement.prototype

ColorMarkerElement.setMarkerType = (markerType) ->
  return if markerType is 'gutter'
  @prototype.renderer = new RENDERERS[markerType]
