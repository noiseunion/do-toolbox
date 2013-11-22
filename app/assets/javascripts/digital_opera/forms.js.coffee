#= require jquery
#= require digital_opera/digital_opera_namespace

((d) ->
  # @method parameterizeObject
  # data [Object]
  # Generate correctly formatted parameters for xhr2
  #
  # {
  #   id: 1234567890,
  #   person: {
  #     first_name: 'Grant',
  #     last_name : 'Klinsing',
  #     meta : {
  #       foo: 'bar',
  #       test: [100, 200]
  #     }
  #   }
  # }
  #
  # Will become:
  #
  # id = 1234567890
  # person[first_name] = 'Grant'
  # person[last_name] = 'Klinsing'
  # person[meta][foo] = 'bar'
  # person[meta][test] = [100, 200]
  d.parameterizeObject = (data) ->
    obj = {}

    accLoop = (key, val) ->
      if $.isPlainObject val
        for k, v of val
          k = "#{key}[#{k}]"
          accLoop(k, v)
      else
        obj[key] = val
      return

    for key, val of data
      accLoop(key, val)

    obj

)(window.digitalOpera)