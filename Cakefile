fs     = require 'fs'
{exec} = require 'child_process'
util   = require 'util'

prodTargetFileName   = 'digital_opera'

prodSrcCoffeeDir     = 'app/assets/javascripts'
prodTargetJsDir      = 'spec/javascripts/src'

prodSrcLessDir       = 'less'
prodTargetCssDir     = 'css'

prodTargetCoffeeFile = "#{prodSrcCoffeeDir}/#{prodTargetFileName}.coffee"
prodTargetJsFile     = "#{prodTargetJsDir}/#{prodTargetFileName}.js"
prodTargetJsMinFile  = "#{prodTargetJsDir}/#{prodTargetFileName}.min.js"

prodCoffeeOpts       = "--bare --output #{prodTargetJsDir} --compile #{prodTargetCoffeeFile}"

runnerFilePath       = '/spec/javascripts/SpecRunner.html'

# -- [ Methods ] ----------------------------------------------------------------

getFiles = (dir) ->
  results = []
  accLoop = (dir) ->
    files = fs.readdirSync dir

    for file in files
      file = dir + "/" + file
      stat = fs.statSync file
      if stat and stat.isDirectory()
        accLoop(file)
      else
        if getExtension(file) == '.coffee'
          results.push file
    return

  accLoop(dir)
  results

getExtension = (filename) ->
  i = filename.lastIndexOf('.')
  if i < 0 then '' else filename.substr(i)

prodCoffeeFiles = getFiles './' + prodSrcCoffeeDir

buildJs = (callback) ->
  util.log "Building #{prodTargetJsFile}"
  appContents = new Array remaining = prodCoffeeFiles.length
  util.log "Appending #{prodCoffeeFiles.length} files to #{prodTargetCoffeeFile}"

  for file, index in prodCoffeeFiles then do (file, index) ->
    fs.readFile "#{file}", 'utf8', (err, fileContents) ->
      util.log err if err

      appContents[index] = fileContents
      util.log "[#{index + 1}] #{file}"
      process(appContents, callback) if --remaining is 0

process = (appContents, callback) ->
  fs.writeFile prodTargetCoffeeFile, appContents.join('\n\n'), 'utf8', (err) ->
    util.log err if err

    exec "coffee #{prodCoffeeOpts}", (err, stdout, stderr) ->
      util.log err if err
      util.log "Compiled #{prodTargetJsFile}"
      fs.unlink prodTargetCoffeeFile, (err) -> util.log err if err
      compileSpecRunner(callback)

compileSpecRunner = (callback) ->
  fs.readFile ".#{runnerFilePath}", 'utf8', (err, fileContents) ->
    util.log err if err

    commentStart = '<!--[specFiles]-->'
    commentEnd = '<!--[/specFiles]-->'
    headIdx = fileContents.indexOf(commentStart)
    head = fileContents.substr(0, headIdx).trim()
    footIdx = fileContents.indexOf(commentEnd) + commentEnd.length
    foot = fileContents.substr(footIdx, fileContents.length).trim()

    html = [head]
    html.push "\n\t#{commentStart}"

    for file in prodCoffeeFiles then do (file) ->
      return unless getExtension(file) == '.coffee'
      arr = file.split('/')
      filename = arr[arr.length - 1]
      filename = filename.replace(/(\.js)?.coffee/, '')

      html.push scriptString(filename)

    html.push "#{commentEnd}\n"
    html.push foot

    fs.writeFile ".#{runnerFilePath}", html.join("\n\t"), 'utf8', (err) ->
      util.log err if err
      util.log "Compiled .#{runnerFilePath}"
      callback()

scriptString = (name) ->
  "<script type=\"text/javascript\" src=\"spec/#{name}_spec.js\"></script>"

runTests = ->
  util.log 'Launching spec browser'
  exec "open #{__dirname}#{runnerFilePath}"

# -- [ Tasks ] ----------------------------------------------------------------

task 'spec', 'Compile JS and launch browser to run specs', ->
  buildJs(runTests)
