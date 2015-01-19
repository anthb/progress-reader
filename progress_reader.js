(function() {
  var ProgressReader;

  ProgressReader = function(element, options) {
    this.options = $.extend({}, this.defaults, options);
    this.element = element;
    this.$element = $(element);
    this.init();
    return this;
  };

  ProgressReader.prototype.defaults = {
    progressReader: 'body'
  };

  ProgressReader.prototype.init = function() {
    this.elementHeight = this.$element.height();
    return $(window).on('scroll.progressReader', {
      current: this,
      $element: this.$element,
      elementHeight: this.elementHeight
    }, this.scrollEvent);
  };

  ProgressReader.prototype.scrollEvent = function(event) {
    var $window, currentWindowPosition, documentHeight, elementOffsetBottom, elementOffsetTop, isElementAtBottom, isElementAtTop, length, progress, scrolled, windowHeight;
    $window = $(window);
    windowHeight = $(window).height();
    documentHeight = $(document).height();
    currentWindowPosition = $window.scrollTop();
    elementOffsetTop = event.data.$element.offset().top;
    elementOffsetBottom = elementOffsetTop + event.data.elementHeight;
    isElementAtBottom = event.data.current.isElementAtBottom(elementOffsetBottom, documentHeight, windowHeight);
    isElementAtTop = elementOffsetTop === 0 ? true : false;
    scrolled = (currentWindowPosition + (isElementAtTop ? 0 : windowHeight)) - elementOffsetTop;
    length = event.data.elementHeight - (isElementAtBottom ? windowHeight : 0);
    progress = 100 * (scrolled / length);
    if (progress >= 0 && progress <= 100) {
      return $('.progress-reader__info').html(progress);
    } else if (progress < 0) {
      return $('.progress-reader__info').html(0);
    } else if (progress > 100) {
      return $('.progress-reader__info').html(100);
    }
  };

  ProgressReader.prototype.isElementAtBottom = function(elementOffsetBottom, documentHeight, windowHeight) {
    if (elementOffsetBottom === documentHeight) {
      return true;
    } else {
      return false;
    }
  };

  $.fn.progressReader = function(options) {
    return this.each(function() {
      var $this, plugin;
      $this = $(this);
      if ($this.data('plugin_exposer') === void 0) {
        plugin = new ProgressReader(this, options);
        return $this.data('plugin_exposer', plugin);
      }
    });
  };

}).call(this);
