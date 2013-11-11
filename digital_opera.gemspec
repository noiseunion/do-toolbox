$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "digital_opera/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "digital_opera"
  s.version     = DigitalOpera::VERSION
  s.authors     = ["JD Hendrickson", "Grant Klinsing"]
  s.email       = ["support@digitalopera.com"]
  s.homepage    = "http://www.digitalopera.com/"
  s.summary     = "Tools and utilities for helping out in developing Ruby applications"
  s.description = "Tools and utilities for helping out in developing Ruby applications"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "activesupport", ">= 3.1.0"

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'mocha', '~> 0.13.1'
  s.add_development_dependency 'guard', '~> 2.2.3'
  s.add_development_dependency 'guard-rspec', '~> 2.3.0'
  s.add_development_dependency 'guard-spork', '~> 1.5.0'
end
