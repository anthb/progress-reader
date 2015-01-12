### What's it doing? ###
# Calculate area height.
# Calculate the offset (where you are currently)
# Work that out as a percentage
# Display and constantly update this

### Done by? ###
# Hooking into the scroll event

### What do we need? ###
# An element to kick things off (body by default)
# A progress element container to show and hide
# A progress element that will be updated with percentage of page read
# Make it AMD.

### To Do ###
# Simple % text
# SVG animations
# images and other stuff


ProgressReader = ( element, options ) ->
  @options = $.extend {}, @defaults, options
  @element = element
  @$element = $(element)
  @init()
  this

ProgressReader::defaults =
  progressReader: 'body'

ProgressReader::init = ->
  @elementHeight = @$element.height()
  $(window).on('scroll.progressReader', {
      current: @, 
      $element: @$element,
      elementHeight: @elementHeight
    } ,@scrollEvent)

ProgressReader::scrollEvent = ( event ) ->
  # event.data.elementHeight
  $window               = $(window)
  windowHeight          = $(window).height() # height of screen
  documentHeight        = $(document).height() # height of entire document
  currentWindowPosition = $window.scrollTop()
  elementOffsetTop      = event.data.$element.offset().top
  elementOffsetBottom   = elementOffsetTop + event.data.elementHeight

  isElementAtBottom = event.data.current.isElementAtBottom(elementOffsetBottom, documentHeight, windowHeight)
  isElementAtTop    = if elementOffsetTop == 0 then true else false

  # Progress Logic
  scrolled = (currentWindowPosition + ( if isElementAtTop then 0 else windowHeight )) - elementOffsetTop
  length = (event.data.elementHeight - ( if isElementAtBottom then windowHeight else 0 ))


  progress = (100 * ( scrolled / length ))
    #progress = ( 100 * scrolled / length )
  if progress >= 0 && progress <= 100
    $('.progress-reader__info').html(progress)
  

ProgressReader::isElementAtBottom = ( elementOffsetBottom, documentHeight, windowHeight ) ->
  return if elementOffsetBottom == documentHeight then true else false

$.fn.progressReader = ( options ) ->
  this.each ->
    $this = $( this )

    if $this.data( 'plugin_exposer' ) is undefined
      plugin = new ProgressReader( this, options )
      $this.data( 'plugin_exposer', plugin )
