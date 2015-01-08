
/* What's it doing? */


/* Done by? */


/* What do we need? */


/* To Do */

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
      $element: this.$element,
      elementHeight: this.elementHeight
    }, this.scrollEvent);
  };

  ProgressReader.prototype.scrollEvent = function(event) {
    var $window, currentWindowPosition, documentHeight, elementOffsetBottom, elementOffsetTop, progress, windowHeight;
    $window = $(window);
    windowHeight = $(window).height();
    documentHeight = $(document).height();
    currentWindowPosition = $window.scrollTop();
    elementOffsetTop = event.data.$element.offset().top;
    elementOffsetBottom = elementOffsetTop + event.data.elementHeight;
    console.log(currentWindowPosition);
    console.log(elementOffsetTop);
    console.log('bottom: ' + elementOffsetBottom);
    console.log(event.data.elementHeight);
    console.log(windowHeight);
    console.log(documentHeight);
    console.log(elementOffsetTop + event.data.elementHeight);
    if (currentWindowPosition > elementOffsetTop) {
      console.log(currentWindowPosition - elementOffsetTop);
      console.log(elementOffsetBottom === documentHeight ? windowHeight : 0);
      console.log(windowHeight);
      progress = 100 * ((currentWindowPosition - elementOffsetTop) / (event.data.elementHeight - (elementOffsetBottom === documentHeight ? windowHeight : 0)));
      return $('.progress-reader__info').html(progress);
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
