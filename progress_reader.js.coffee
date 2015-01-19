# To Do #
# Simple % text
# Option to fade in the progress-reader__info
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
  # Want to keep these variables declared inside the handler as the DOM may update and the values could change.

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
  else if progress < 0 # Scrolling can be faster than the tracked progress and will stop on a value higher than 0 (same for over 100)
    $('.progress-reader__info').html(0)
  else if progress > 100
    $('.progress-reader__info').html(100)
  

ProgressReader::isElementAtBottom = ( elementOffsetBottom, documentHeight, windowHeight ) ->
  return if elementOffsetBottom == documentHeight then true else false

$.fn.progressReader = ( options ) ->
  this.each ->
    $this = $( this )

    if $this.data( 'plugin_exposer' ) is undefined
      plugin = new ProgressReader( this, options )
      $this.data( 'plugin_exposer', plugin )
