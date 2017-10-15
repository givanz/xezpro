/*!
 * imagesLoaded PACKAGED v3.1.4
 * JavaScript is all like "You images are done yet or what?"
 * MIT License
 */

(function(){function e(){}function t(e,t){for(var n=e.length;n--;)if(e[n].listener===t)return n;return-1}function n(e){return function(){return this[e].apply(this,arguments)}}var i=e.prototype,r=this,o=r.EventEmitter;i.getListeners=function(e){var t,n,i=this._getEvents();if("object"==typeof e){t={};for(n in i)i.hasOwnProperty(n)&&e.test(n)&&(t[n]=i[n])}else t=i[e]||(i[e]=[]);return t},i.flattenListeners=function(e){var t,n=[];for(t=0;e.length>t;t+=1)n.push(e[t].listener);return n},i.getListenersAsObject=function(e){var t,n=this.getListeners(e);return n instanceof Array&&(t={},t[e]=n),t||n},i.addListener=function(e,n){var i,r=this.getListenersAsObject(e),o="object"==typeof n;for(i in r)r.hasOwnProperty(i)&&-1===t(r[i],n)&&r[i].push(o?n:{listener:n,once:!1});return this},i.on=n("addListener"),i.addOnceListener=function(e,t){return this.addListener(e,{listener:t,once:!0})},i.once=n("addOnceListener"),i.defineEvent=function(e){return this.getListeners(e),this},i.defineEvents=function(e){for(var t=0;e.length>t;t+=1)this.defineEvent(e[t]);return this},i.removeListener=function(e,n){var i,r,o=this.getListenersAsObject(e);for(r in o)o.hasOwnProperty(r)&&(i=t(o[r],n),-1!==i&&o[r].splice(i,1));return this},i.off=n("removeListener"),i.addListeners=function(e,t){return this.manipulateListeners(!1,e,t)},i.removeListeners=function(e,t){return this.manipulateListeners(!0,e,t)},i.manipulateListeners=function(e,t,n){var i,r,o=e?this.removeListener:this.addListener,s=e?this.removeListeners:this.addListeners;if("object"!=typeof t||t instanceof RegExp)for(i=n.length;i--;)o.call(this,t,n[i]);else for(i in t)t.hasOwnProperty(i)&&(r=t[i])&&("function"==typeof r?o.call(this,i,r):s.call(this,i,r));return this},i.removeEvent=function(e){var t,n=typeof e,i=this._getEvents();if("string"===n)delete i[e];else if("object"===n)for(t in i)i.hasOwnProperty(t)&&e.test(t)&&delete i[t];else delete this._events;return this},i.removeAllListeners=n("removeEvent"),i.emitEvent=function(e,t){var n,i,r,o,s=this.getListenersAsObject(e);for(r in s)if(s.hasOwnProperty(r))for(i=s[r].length;i--;)n=s[r][i],n.once===!0&&this.removeListener(e,n.listener),o=n.listener.apply(this,t||[]),o===this._getOnceReturnValue()&&this.removeListener(e,n.listener);return this},i.trigger=n("emitEvent"),i.emit=function(e){var t=Array.prototype.slice.call(arguments,1);return this.emitEvent(e,t)},i.setOnceReturnValue=function(e){return this._onceReturnValue=e,this},i._getOnceReturnValue=function(){return this.hasOwnProperty("_onceReturnValue")?this._onceReturnValue:!0},i._getEvents=function(){return this._events||(this._events={})},e.noConflict=function(){return r.EventEmitter=o,e},"function"==typeof define&&define.amd?define("eventEmitter/EventEmitter",[],function(){return e}):"object"==typeof module&&module.exports?module.exports=e:this.EventEmitter=e}).call(this),function(e){function t(t){var n=e.event;return n.target=n.target||n.srcElement||t,n}var n=document.documentElement,i=function(){};n.addEventListener?i=function(e,t,n){e.addEventListener(t,n,!1)}:n.attachEvent&&(i=function(e,n,i){e[n+i]=i.handleEvent?function(){var n=t(e);i.handleEvent.call(i,n)}:function(){var n=t(e);i.call(e,n)},e.attachEvent("on"+n,e[n+i])});var r=function(){};n.removeEventListener?r=function(e,t,n){e.removeEventListener(t,n,!1)}:n.detachEvent&&(r=function(e,t,n){e.detachEvent("on"+t,e[t+n]);try{delete e[t+n]}catch(i){e[t+n]=void 0}});var o={bind:i,unbind:r};"function"==typeof define&&define.amd?define("eventie/eventie",o):e.eventie=o}(this),function(e,t){"function"==typeof define&&define.amd?define(["eventEmitter/EventEmitter","eventie/eventie"],function(n,i){return t(e,n,i)}):"object"==typeof exports?module.exports=t(e,require("eventEmitter"),require("eventie")):e.imagesLoaded=t(e,e.EventEmitter,e.eventie)}(this,function(e,t,n){function i(e,t){for(var n in t)e[n]=t[n];return e}function r(e){return"[object Array]"===d.call(e)}function o(e){var t=[];if(r(e))t=e;else if("number"==typeof e.length)for(var n=0,i=e.length;i>n;n++)t.push(e[n]);else t.push(e);return t}function s(e,t,n){if(!(this instanceof s))return new s(e,t);"string"==typeof e&&(e=document.querySelectorAll(e)),this.elements=o(e),this.options=i({},this.options),"function"==typeof t?n=t:i(this.options,t),n&&this.on("always",n),this.getImages(),a&&(this.jqDeferred=new a.Deferred);var r=this;setTimeout(function(){r.check()})}function c(e){this.img=e}function f(e){this.src=e,v[e]=this}var a=e.jQuery,u=e.console,h=u!==void 0,d=Object.prototype.toString;s.prototype=new t,s.prototype.options={},s.prototype.getImages=function(){this.images=[];for(var e=0,t=this.elements.length;t>e;e++){var n=this.elements[e];"IMG"===n.nodeName&&this.addImage(n);for(var i=n.querySelectorAll("img"),r=0,o=i.length;o>r;r++){var s=i[r];this.addImage(s)}}},s.prototype.addImage=function(e){var t=new c(e);this.images.push(t)},s.prototype.check=function(){function e(e,r){return t.options.debug&&h&&u.log("confirm",e,r),t.progress(e),n++,n===i&&t.complete(),!0}var t=this,n=0,i=this.images.length;if(this.hasAnyBroken=!1,!i)return this.complete(),void 0;for(var r=0;i>r;r++){var o=this.images[r];o.on("confirm",e),o.check()}},s.prototype.progress=function(e){this.hasAnyBroken=this.hasAnyBroken||!e.isLoaded;var t=this;setTimeout(function(){t.emit("progress",t,e),t.jqDeferred&&t.jqDeferred.notify&&t.jqDeferred.notify(t,e)})},s.prototype.complete=function(){var e=this.hasAnyBroken?"fail":"done";this.isComplete=!0;var t=this;setTimeout(function(){if(t.emit(e,t),t.emit("always",t),t.jqDeferred){var n=t.hasAnyBroken?"reject":"resolve";t.jqDeferred[n](t)}})},a&&(a.fn.imagesLoaded=function(e,t){var n=new s(this,e,t);return n.jqDeferred.promise(a(this))}),c.prototype=new t,c.prototype.check=function(){var e=v[this.img.src]||new f(this.img.src);if(e.isConfirmed)return this.confirm(e.isLoaded,"cached was confirmed"),void 0;if(this.img.complete&&void 0!==this.img.naturalWidth)return this.confirm(0!==this.img.naturalWidth,"naturalWidth"),void 0;var t=this;e.on("confirm",function(e,n){return t.confirm(e.isLoaded,n),!0}),e.check()},c.prototype.confirm=function(e,t){this.isLoaded=e,this.emit("confirm",this,t)};var v={};return f.prototype=new t,f.prototype.check=function(){if(!this.isChecked){var e=new Image;n.bind(e,"load",this),n.bind(e,"error",this),e.src=this.src,this.isChecked=!0}},f.prototype.handleEvent=function(e){var t="on"+e.type;this[t]&&this[t](e)},f.prototype.onload=function(e){this.confirm(!0,"onload"),this.unbindProxyEvents(e)},f.prototype.onerror=function(e){this.confirm(!1,"onerror"),this.unbindProxyEvents(e)},f.prototype.confirm=function(e,t){this.isConfirmed=!0,this.isLoaded=e,this.emit("confirm",this,t)},f.prototype.unbindProxyEvents=function(e){n.unbind(e.target,"load",this),n.unbind(e.target,"error",this)},s});


/*!
  jQuery Wookmark plugin
  @name jquery.wookmark.js
  @author Christoph Ono (chri@sto.ph or @gbks)
  @author Sebastian Helzle (sebastian@helzle.net or @sebobo)
  @version 1.4.6
  @date 12/07/2013
  @category jQuery plugin
  @copyright (c) 2009-2013 Christoph Ono (www.wookmark.com)
  @license Licensed under the MIT (http://www.opensource.org/licenses/mit-license.php) license.
*/
(function (factory) {
  if (typeof define === 'function' && define.amd)
    define(['jquery'], factory);
  else
    factory(jQuery);
}(function ($) {
  var Wookmark, defaultOptions, __bind;

  __bind = function(fn, me) {
    return function() {
      return fn.apply(me, arguments);
    };
  };

  // Wookmark default options
  defaultOptions = {
    align: 'center',
    autoResize: false,
    comparator: null,
    container: $('body'),
    direction: undefined,
    ignoreInactiveItems: true,
    itemWidth: 0,
    fillEmptySpace: false,
    flexibleWidth: 0,
    offset: 2,
    outerOffset: 0,
    onLayoutChanged: undefined,
    possibleFilters: [],
    resizeDelay: 50,
    verticalOffset: undefined
  };

  // Function for executing css writes to dom on the next animation frame if supported
  var executeNextFrame = window.requestAnimationFrame || function(callback) {callback();};

  function bulkUpdateCSS(data) {
    executeNextFrame(function() {
      var i, item;
      for (i = 0; i < data.length; i++) {
        item = data[i];
        item.obj.css(item.css);
      }
    });
  }

  function cleanFilterName(filterName) {
    return $.trim(filterName).toLowerCase();
  }

  // Main wookmark plugin class
  Wookmark = (function() {

    function Wookmark(handler, options) {
      // Instance variables.
      this.handler = handler;
      this.columns = this.containerWidth = this.resizeTimer = null;
      this.activeItemCount = 0;
      this.itemHeightsDirty = true;
      this.placeholders = [];

      $.extend(true, this, defaultOptions, options);

      this.verticalOffset = this.verticalOffset || this.offset;

      // Bind instance methods
      this.update = __bind(this.update, this);
      this.onResize = __bind(this.onResize, this);
      this.onRefresh = __bind(this.onRefresh, this);
      this.getItemWidth = __bind(this.getItemWidth, this);
      this.layout = __bind(this.layout, this);
      this.layoutFull = __bind(this.layoutFull, this);
      this.layoutColumns = __bind(this.layoutColumns, this);
      this.filter = __bind(this.filter, this);
      this.clear = __bind(this.clear, this);
      this.getActiveItems = __bind(this.getActiveItems, this);
      this.refreshPlaceholders = __bind(this.refreshPlaceholders, this);
      this.sortElements = __bind(this.sortElements, this);
      this.updateFilterClasses = __bind(this.updateFilterClasses, this);

      // Initial update of the filter classes
      this.updateFilterClasses();

      // Listen to resize event if requested.
      if (this.autoResize)
        $(window).bind('resize.wookmark', this.onResize);

      this.container.bind('refreshWookmark', this.onRefresh);
    }

    Wookmark.prototype.updateFilterClasses = function() {
      // Collect filter data
      var i = 0, j = 0, k = 0, filterClasses = {}, itemFilterClasses,
          $item, filterClass, possibleFilters = this.possibleFilters, possibleFilter;

      for (; i < this.handler.length; i++) {
        $item = this.handler.eq(i);

        // Read filter classes and globally store each filter class as object and the fitting items in the array
        itemFilterClasses = $item.data('filterClass');
        if (typeof itemFilterClasses == 'object' && itemFilterClasses.length > 0) {
          for (j = 0; j < itemFilterClasses.length; j++) {
            filterClass = cleanFilterName(itemFilterClasses[j]);

            if (!filterClasses[filterClass]) {
              filterClasses[filterClass] = [];
            }
            filterClasses[filterClass].push($item[0]);
          }
        }
      }

      for (; k < possibleFilters.length; k++) {
        possibleFilter = cleanFilterName(possibleFilters[k]);
        if (!(possibleFilter in filterClasses)) {
          filterClasses[possibleFilter] = [];
        }
      }

      this.filterClasses = filterClasses;
    };

    // Method for updating the plugins options
    Wookmark.prototype.update = function(options) {
      this.itemHeightsDirty = true;
      $.extend(true, this, options);
    };

    // This timer ensures that layout is not continuously called as window is being dragged.
    Wookmark.prototype.onResize = function() {
      clearTimeout(this.resizeTimer);
      this.itemHeightsDirty = this.flexibleWidth !== 0;
      this.resizeTimer = setTimeout(this.layout, this.resizeDelay);
    };

    // Marks the items heights as dirty and does a relayout
    Wookmark.prototype.onRefresh = function() {
      this.itemHeightsDirty = true;
      this.layout();
    };

    /**
     * Filters the active items with the given string filters.
     * @param filters array of string
     * @param mode 'or' or 'and'
     */
    Wookmark.prototype.filter = function(filters, mode) {
      var activeFilters = [], activeFiltersLength, activeItems = $(),
          i, j, k, filter;

      filters = filters || [];
      mode = mode || 'or';

      if (filters.length) {
        // Collect active filters
        for (i = 0; i < filters.length; i++) {
          filter = cleanFilterName(filters[i]);
          if (filter in this.filterClasses) {
            activeFilters.push(this.filterClasses[filter]);
          }
        }

        // Get items for active filters with the selected mode
        activeFiltersLength = activeFilters.length;
        if (mode == 'or' || activeFiltersLength == 1) {
          // Set all items in all active filters active
          for (i = 0; i < activeFiltersLength; i++) {
            activeItems = activeItems.add(activeFilters[i]);
          }
        } else if (mode == 'and') {
          var shortestFilter = activeFilters[0],
              itemValid = true, foundInFilter,
              currentItem, currentFilter;

          // Find shortest filter class
          for (i = 1; i < activeFiltersLength; i++) {
            if (activeFilters[i].length < shortestFilter.length) {
              shortestFilter = activeFilters[i];
            }
          }

          // Iterate over shortest filter and find elements in other filter classes
          shortestFilter = shortestFilter || [];
          for (i = 0; i < shortestFilter.length; i++) {
            currentItem = shortestFilter[i];
            itemValid = true;

            for (j = 0; j < activeFilters.length && itemValid; j++) {
              currentFilter = activeFilters[j];
              if (shortestFilter == currentFilter) continue;

              // Search for current item in each active filter class
              for (k = 0, foundInFilter = false; k < currentFilter.length && !foundInFilter; k++) {
                foundInFilter = currentFilter[k] == currentItem;
              }
              itemValid &= foundInFilter;
            }
            if (itemValid)
              activeItems.push(shortestFilter[i]);
          }
        }
        // Hide inactive items
        this.handler.not(activeItems).addClass('inactive');
      } else {
        // Show all items if no filter is selected
        activeItems = this.handler;
      }

      // Show active items
      activeItems.removeClass('inactive');

      // Unset columns and refresh grid for a full layout
      this.columns = null;
      this.layout();
    };

    /**
     * Creates or updates existing placeholders to create columns of even height
     */
    Wookmark.prototype.refreshPlaceholders = function(columnWidth, sideOffset) {
      var i = this.placeholders.length,
          $placeholder, $lastColumnItem,
          columnsLength = this.columns.length, column,
          height, top, innerOffset,
          containerHeight = this.container.innerHeight();

      for (; i < columnsLength; i++) {
        $placeholder = $('<div class="wookmark-placeholder"/>').appendTo(this.container);
        this.placeholders.push($placeholder);
      }

      innerOffset = this.offset + parseInt(this.placeholders[0].css('borderLeftWidth'), 10) * 2;

      for (i = 0; i < this.placeholders.length; i++) {
        $placeholder = this.placeholders[i];
        column = this.columns[i];

        if (i >= columnsLength || !column[column.length - 1]) {
          $placeholder.css('display', 'none');
        } else {
          $lastColumnItem = column[column.length - 1];
          if (!$lastColumnItem) continue;
          top = $lastColumnItem.data('wookmark-top') + $lastColumnItem.data('wookmark-height') + this.verticalOffset;
          height = containerHeight - top - innerOffset;

          $placeholder.css({
            position: 'absolute',
            display: height > 0 ? 'block' : 'none',
            left: i * columnWidth + sideOffset,
            top: top,
            width: columnWidth - innerOffset,
            height: height
          });
        }
      }
    };

    // Method the get active items which are not disabled and visible
    Wookmark.prototype.getActiveItems = function() {
      return this.ignoreInactiveItems ? this.handler.not('.inactive') : this.handler;
    };

    // Method to get the standard item width
    Wookmark.prototype.getItemWidth = function() {
      var itemWidth = this.itemWidth,
          innerWidth = this.container.width() - 2 * this.outerOffset,
          firstElement = this.handler.eq(0),
          flexibleWidth = this.flexibleWidth;

      if (this.itemWidth === undefined || this.itemWidth === 0 && !this.flexibleWidth) {
        itemWidth = firstElement.outerWidth();
      }
      else if (typeof this.itemWidth == 'string' && this.itemWidth.indexOf('%') >= 0) {
        itemWidth = parseFloat(this.itemWidth) / 100 * innerWidth;
      }

      // Calculate flexible item width if option is set
      if (flexibleWidth) {
        if (typeof flexibleWidth == 'string' && flexibleWidth.indexOf('%') >= 0) {
          flexibleWidth = parseFloat(flexibleWidth) / 100 * innerWidth;
        }

        // Find highest column count
        var paddedInnerWidth = (innerWidth + this.offset),
            flexibleColumns = ~~(0.5 + paddedInnerWidth / (flexibleWidth + this.offset)),
            fixedColumns = ~~(paddedInnerWidth / (itemWidth + this.offset)),
            columns = Math.max(flexibleColumns, fixedColumns),
            columnWidth = Math.min(flexibleWidth, ~~((innerWidth - (columns - 1) * this.offset) / columns));

        itemWidth = Math.max(itemWidth, columnWidth);

        // Stretch items to fill calculated width
        this.handler.css('width', itemWidth);
      }

      return itemWidth;
    };

    // Main layout method.
    Wookmark.prototype.layout = function(force) {
      // Do nothing if container isn't visible
      if (!this.container.is(':visible')) return;

      // Calculate basic layout parameters.
      var columnWidth = this.getItemWidth() + this.offset,
          containerWidth = this.container.width(),
          innerWidth = containerWidth - 2 * this.outerOffset,
          columns = ~~((innerWidth + this.offset) / columnWidth),
          offset = 0, maxHeight = 0, i = 0,
          activeItems = this.getActiveItems(),
          activeItemsLength = activeItems.length,
          $item;

      // Cache item height
      if (this.itemHeightsDirty || !this.container.data('itemHeightsInitialized')) {
        for (; i < activeItemsLength; i++) {
          $item = activeItems.eq(i);
          $item.data('wookmark-height', $item.outerHeight());
        }
        this.itemHeightsDirty = false;
        this.container.data('itemHeightsInitialized', true);
      }

      // Use less columns if there are to few items
      columns = Math.max(1, Math.min(columns, activeItemsLength));

      // Calculate the offset based on the alignment of columns to the parent container
      offset = this.outerOffset;
      if (this.align == 'center') {
        offset += ~~(0.5 + (innerWidth - (columns * columnWidth - this.offset)) >> 1);
      }

      // Get direction for positioning
      this.direction = this.direction || (this.align == 'right' ? 'right' : 'left');

      // If container and column count hasn't changed, we can only update the columns.
      if (!force && this.columns !== null && this.columns.length == columns && this.activeItemCount == activeItemsLength) {
        maxHeight = this.layoutColumns(columnWidth, offset);
      } else {
        maxHeight = this.layoutFull(columnWidth, columns, offset);
      }
      this.activeItemCount = activeItemsLength;

      // Set container height to height of the grid.
      this.container.css('height', maxHeight);

      // Update placeholders
      if (this.fillEmptySpace) {
        this.refreshPlaceholders(columnWidth, offset);
      }

      if (this.onLayoutChanged !== undefined && typeof this.onLayoutChanged === 'function') {
        this.onLayoutChanged();
      }
    };

    /**
     * Sort elements with configurable comparator
     */
    Wookmark.prototype.sortElements = function(elements) {
      return typeof(this.comparator) === 'function' ? elements.sort(this.comparator) : elements;
    };

    /**
     * Perform a full layout update.
     */
    Wookmark.prototype.layoutFull = function(columnWidth, columns, offset) {
      var $item, i = 0, k = 0,
          activeItems = $.makeArray(this.getActiveItems()),
          length = activeItems.length,
          shortest = null, shortestIndex = null,
          sideOffset, heights = [], itemBulkCSS = [],
          leftAligned = this.align == 'left' ? true : false;

      this.columns = [];

      // Sort elements before layouting
      activeItems = this.sortElements(activeItems);

      // Prepare arrays to store height of columns and items.
      while (heights.length < columns) {
        heights.push(this.outerOffset);
        this.columns.push([]);
      }

      // Loop over items.
      for (; i < length; i++ ) {
        $item = $(activeItems[i]);

        // Find the shortest column.
        shortest = heights[0];
        shortestIndex = 0;
        for (k = 0; k < columns; k++) {
          if (heights[k] < shortest) {
            shortest = heights[k];
            shortestIndex = k;
          }
        }
        $item.data('wookmark-top', shortest);

        // stick to left side if alignment is left and this is the first column
        sideOffset = offset;
        if (shortestIndex > 0 || !leftAligned)
          sideOffset += shortestIndex * columnWidth;

        // Position the item.
        (itemBulkCSS[i] = {
          obj: $item,
          css: {
            position: 'absolute',
            top: shortest
          }
        }).css[this.direction] = sideOffset;

        // Update column height and store item in shortest column
        heights[shortestIndex] += $item.data('wookmark-height') + this.verticalOffset;
        this.columns[shortestIndex].push($item);
      }

      bulkUpdateCSS(itemBulkCSS);

      // Return longest column
      return Math.max.apply(Math, heights);
    };

    /**
     * This layout method only updates the vertical position of the
     * existing column assignments.
     */
    Wookmark.prototype.layoutColumns = function(columnWidth, offset) {
      var heights = [], itemBulkCSS = [],
          i = 0, k = 0, j = 0, currentHeight,
          column, $item, itemData, sideOffset;

      for (; i < this.columns.length; i++) {
        heights.push(this.outerOffset);
        column = this.columns[i];
        sideOffset = i * columnWidth + offset;
        currentHeight = heights[i];

        for (k = 0; k < column.length; k++, j++) {
          $item = column[k].data('wookmark-top', currentHeight);
          (itemBulkCSS[j] = {
            obj: $item,
            css: {
              top: currentHeight
            }
          }).css[this.direction] = sideOffset;

          currentHeight += $item.data('wookmark-height') + this.verticalOffset;
        }
        heights[i] = currentHeight;
      }

      bulkUpdateCSS(itemBulkCSS);

      // Return longest column
      return Math.max.apply(Math, heights);
    };

    /**
     * Clear event listeners and time outs and the instance itself
     */
    Wookmark.prototype.clear = function() {
      clearTimeout(this.resizeTimer);
      $(window).unbind('resize.wookmark', this.onResize);
      this.container.unbind('refreshWookmark', this.onRefresh);
      this.handler.wookmarkInstance = null;
    };

    return Wookmark;
  })();

  $.fn.wookmark = function(options) {
    // Create a wookmark instance if not available
    if (!this.wookmarkInstance) {
      this.wookmarkInstance = new Wookmark(this, options || {});
    } else {
      this.wookmarkInstance.update(options || {});
    }

    // Apply layout
    this.wookmarkInstance.layout(true);

    // Display items (if hidden) and return jQuery object to maintain chainability
    return this.show();
  };
}));
