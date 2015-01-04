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
  windowHeight = $(window).height()
  currentPosition = (event.data.$element.scrollTop())

  progress = 100 * (currentPosition / (event.data.elementHeight - windowHeight))
  $('.progress-reader__info').html(progress)


$.fn.progressReader = ( options ) ->
  this.each ->
    $this = $( this )

    if $this.data( 'plugin_exposer' ) is undefined
      plugin = new ProgressReader( this, options )
      $this.data( 'plugin_exposer', plugin )
