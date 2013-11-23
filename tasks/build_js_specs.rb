class BuildJsSpecs
  TARGET_FILE_NAME   = 'digital_opera'
  SRC_COFFEE_DIR     = 'app/assets/javascripts'
  TARGET_JS_DIR      = 'spec/javascripts/src'
  TARGET_COFFEE_FILE = "#{SRC_COFFEE_DIR}/#{TARGET_FILE_NAME}.coffee"
  COFFEE_OPTS        = "--bare --output #{TARGET_JS_DIR} --compile #{TARGET_COFFEE_FILE}"
  RUNNER_FILE_PATH   = './spec/javascripts/SpecRunner.html'
  COMMENT_START      = '<!--[specFiles]-->'
  COMMENT_END        = '<!--[/specFiles]-->'
  SRC_FILES          = Dir["#{SRC_COFFEE_DIR}/**/*.coffee"]
  SPEC_FILES         = Dir["spec/javascripts/spec/**/*_spec.js"]

  def self.start
    self.create_src_coffee
    self.compile_coffeescript
    self.create_runner
    self.launch_runner
  end

  def self.compile_coffeescript
    system("coffee #{COFFEE_OPTS}") or exit!(1)
    File.unlink TARGET_COFFEE_FILE
  end

  def self.script_string(name)
    "<script type=\"text/javascript\" src=\"spec/#{name}\"></script>"
  end

  def self.create_src_coffee
    contents = SRC_FILES.map do |f|
      file = File.open f, 'rb'
      file.read
    end

    File.open(TARGET_COFFEE_FILE, 'w+b'){ |f| f.write contents.join("\n\n") }
  end

  def self.create_runner
    file_contents = File.open(RUNNER_FILE_PATH, 'rb') {|f| f.read}
    head_idx = file_contents.index COMMENT_START
    foot_idx = file_contents.index(COMMENT_END) + COMMENT_END.length
    head = file_contents[0..(head_idx-1)]
    foot = file_contents[foot_idx..file_contents.length]

    scripts = SPEC_FILES.map do |f|
      filename = Pathname.new(f).basename
      script_string filename
    end

    File.open(RUNNER_FILE_PATH, 'w+b') do |f|
      f.write "#{head}#{COMMENT_START}\n\t#{scripts.join("\n\t")}\n\t#{COMMENT_END}#{foot}"
    end
  end

  def self.launch_runner
    system("open #{File.dirname('./')}/#{RUNNER_FILE_PATH}") or exit!(1)
  end
end

BuildJsSpecs.start