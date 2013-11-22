#= require jquery
#= require digital_opera/digital_opera_namespace

((d) ->
  d.capitalize = (str) ->
    str.charAt(0).toUpperCase() + str.slice(1)

  # @method titleize
  # str [String]
  # Titleize a string
  d.titleize = (str) ->
    arr = str.split(' ')
    newString = ''
    for string in arr
      arr[_i] = string.charAt(0).toUpperCase() + string.slice(1).toLowerCase()
    arr.join(' ')

  # @method formatJSONErrors
  # str [String, Object]
  # withKeys [Boolean]
  # Takes a JSON object and convert it to a readable sentence
  #
  # Example:
  # {email: ["must be at least 6 characters","must contain a number and a letter"]}
  # will be translated to:
  # ["email must be at least 6 characters and must contain a number and a letter"]
  d.formatJSONErrors = (str, withKeys) ->
    errors = if typeof str == 'string' then JSON.parse(str) else str
    $.map errors, (val, key) ->
      values = val.join(' and ')
      str = d.capitalize "#{key} #{values}"

      if withKeys?
        obj = {}
        obj[key] = str
        obj
      else
        str

)(window.digitalOpera)