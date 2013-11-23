// Generated by CoffeeScript 1.6.3
window.digitalOpera = window.digitalOpera || {};

(function(d) {
  return d.ellipsis = function(el) {
    var counter, ele, timer;
    ele = $(el);
    counter = 0;
    return timer = setInterval(function() {
      var arr, num;
      counter++;
      if (counter > 3) {
        counter = 0;
      }
      num = 0;
      arr = [];
      while (num < counter) {
        num++;
        arr.push('.');
      }
      return ele.text(arr.join(''));
    }, 750);
  };
})(window.digitalOpera);

$('[data-does="animate-ellipsis"]').each(function(idx, ele) {
  return window.digitalOpera.ellipsis(ele);
});

(function(d) {
  return d.isClickOutsideElement = function(event, element) {
    var target;
    target = $(event.target);
    if (target[0] === element[0] || element.children(target).length > 0) {
      return false;
    } else {
      return true;
    }
  };
})(window.digitalOpera);

(function(d) {
  return d.parameterizeObject = function(data) {
    var accLoop, key, obj, val;
    obj = {};
    accLoop = function(key, val) {
      var k, v;
      if ($.isPlainObject(val)) {
        for (k in val) {
          v = val[k];
          k = "" + key + "[" + k + "]";
          accLoop(k, v);
        }
      } else {
        obj[key] = val;
      }
    };
    for (key in data) {
      val = data[key];
      accLoop(key, val);
    }
    return obj;
  };
})(window.digitalOpera);

(function(d) {
  return d.preloadImages = function(urls, callback) {
    var images, increment, numLoaded;
    if (typeof urls === 'string') {
      urls = [urls];
    }
    images = [];
    numLoaded = 0;
    increment = function() {
      numLoaded++;
      if ((callback != null) && numLoaded === urls.length) {
        return callback();
      }
    };
    return urls.map(function(url, i) {
      var img;
      img = images[i];
      img = new Image();
      img.onload = increment;
      img.onerror = increment;
      img.src = url;
      return img;
    });
  };
})(window.digitalOpera);

(function(d) {
  d.capitalize = function(str) {
    return str.charAt(0).toUpperCase() + str.slice(1);
  };
  d.titleize = function(str) {
    var arr, newString, string, _i, _len;
    arr = str.split(' ');
    newString = '';
    for (_i = 0, _len = arr.length; _i < _len; _i++) {
      string = arr[_i];
      arr[_i] = string.charAt(0).toUpperCase() + string.slice(1).toLowerCase();
    }
    return arr.join(' ');
  };
  return d.formatJSONErrors = function(str, withKeys) {
    var errors;
    errors = typeof str === 'string' ? JSON.parse(str) : str;
    return $.map(errors, function(val, key) {
      var obj, values;
      values = val.join(' and ');
      str = d.capitalize("" + key + " " + values);
      if (withKeys != null) {
        obj = {};
        obj[key] = str;
        return obj;
      } else {
        return str;
      }
    });
  };
})(window.digitalOpera);

(function(d) {
  $(document).on('click', 'tr[data-href]', function(e) {
    var currentTarget, href, location, target, win;
    target = $(e.target);
    currentTarget = $(e.currentTarget);
    if (target.is('a') === false && target.parents('a').length === 0) {
      href = currentTarget.attr('data-href');
      if (currentTarget.attr('data-does') === 'open-window') {
        win = window.open(href, '_blank');
        return win.focus();
      } else {
        location = d.forTestingPurposes.getWindowLocation();
        return location = href;
      }
    }
  });
  return d.forTestingPurposes = (function() {
    var getWindowLocation;
    getWindowLocation = function() {
      return window.location;
    };
    return {
      getWindowLocation: getWindowLocation
    };
  })();
})(window.digitalOpera);