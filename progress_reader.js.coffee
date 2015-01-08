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
      $element: @$element,
      elementHeight: @elementHeight
    } ,@scrollEvent)

ProgressReader::scrollEvent = ( event ) ->
  # event.data.elementHeight
  $window = $(window)
  windowHeight = $(window).height() # height of screen
  documentHeight = $(document).height() # height of entire document

  currentWindowPosition = $window.scrollTop()
  elementOffsetTop = event.data.$element.offset().top
  elementOffsetBottom = elementOffsetTop + event.data.elementHeight
  #currentWindowPosition = (event.data.$element.scrollTop())

  console.log(currentWindowPosition)
  console.log(elementOffsetTop)
  console.log('bottom: ' + elementOffsetBottom)
  console.log(event.data.elementHeight)
  console.log(windowHeight)
  console.log(documentHeight)
  console.log(elementOffsetTop + event.data.elementHeight)

  # Inside the range (not upper limit, just lower)
  if currentWindowPosition > elementOffsetTop

    console.log( currentWindowPosition - elementOffsetTop)
    console.log( if elementOffsetBottom == documentHeight then windowHeight else 0)
    console.log(windowHeight)

    #progress = 100 * ((currentWindowPosition - event.data.elementHeight) / (event.data.elementHeight - windowHeight))
    progress = (100 * ((currentWindowPosition - elementOffsetTop) / (event.data.elementHeight - ( if elementOffsetBottom == documentHeight then windowHeight else 0 ))))
    #progress = 
    $('.progress-reader__info').html(progress)
  


$.fn.progressReader = ( options ) ->
  this.each ->
    $this = $( this )

    if $this.data( 'plugin_exposer' ) is undefined
      plugin = new ProgressReader( this, options )
      $this.data( 'plugin_exposer', plugin )
