#= require jquery
#
# Animate an ellipsis witin elements with the attribute 'data-does="animate-ellipsis"'
# Frame 1 .
# Frame 2 ..
# Frame 3 ...
# Frame 4 .
# Etc..
((d) ->
  d.ellipsis = (el) ->
    ele       = $(el)
    counter   = 0
    timer     = setInterval () ->
      counter++
      counter = 0 if counter > 3
      num     = 0
      arr     = []
      while num < counter
        num++
        arr.push '.'

      ele.text arr.join('')
    , 750

)(window.digitalOpera)

$('[data-does="animate-ellipsis"]').each (idx, ele) ->
  window.digitalOpera.ellipsis(ele)