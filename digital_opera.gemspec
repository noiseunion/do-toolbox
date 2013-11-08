$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "digital_opera/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "digital_opera"
  s.version     = DigitalOpera::VERSION
  s.authors     = ["JD Hendrickson"]
  s.email       = ["jd@digitalopera.com"]
  s.homepage    = "http://www.digitalopera.com/"
  s.summary     = "Tools and utilities for helping out in developing Ruby applications"
  s.description = "Tools and utilities for helping out in developing Ruby applications"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "active_support", ">= 3.1.0"

  s.add_development_dependency "rspec"
end
