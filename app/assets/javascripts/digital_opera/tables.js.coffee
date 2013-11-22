#= require jquery
#= require digital_opera/digital_opera_namespace

((d) ->
  $(document).on 'click', 'tr[data-href]', (e) ->
    target = $(e.target)
    currentTarget = $(e.currentTarget)

    if target.is('a') == false && target.parents('a').length == 0 # check to make sure click isn't within a link
      href = currentTarget.attr('data-href')
      if currentTarget.attr('data-does') == 'open-window'
        win = window.open(href, '_blank')
        win.focus()
      else
        location = d.forTestingPurposes.getWindowLocation()
        location = href

  # this really sucks, but in order to test everything, we need to mock
  # window.location since it can NOT be spied on. #lame
  d.forTestingPurposes = (->
    getWindowLocation = ->
      return window.location;

    return {
      getWindowLocation: getWindowLocation
    }
  )();
)(window.digitalOpera)