
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
    var currentPosition, progress, windowHeight;
    windowHeight = $(window).height();
    currentPosition = event.data.$element.scrollTop();
    progress = 100 * (currentPosition / (event.data.elementHeight - windowHeight));
    return $('.progress-reader__info').html(progress);
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
