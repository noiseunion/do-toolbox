#= require digital_opera/digital_opera_namespace

((d) ->
  # @method preloadImages
  # urls [String, Array]
  # callback [Function]
  # callback fired when all images have loaded
  d.preloadImages = (urls, callback) ->
    urls = [urls] if typeof urls == 'string'
    images = []
    numLoaded = 0
    increment = ->
      numLoaded++
      if callback? && numLoaded == urls.length
        callback()
    urls.map (url, i) ->
      img = images[i]
      img = new Image()
      # we want to increment on each of these events
      img.onload = increment
      img.onerror = increment
      img.src = url
      img

)(window.digitalOpera)