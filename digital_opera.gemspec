lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
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
  s.license     = 'MIT'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = s.files.grep(%r{^spec/})
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "rails", ">= 3.1.0"
  s.add_dependency 'coffee-rails'

  s.add_development_dependency 'aws-sdk',     '~> 1.0'
  s.add_development_dependency 'bundler',     '~> 1.3'
  s.add_development_dependency 'rake',        '~> 10.1.0'
  s.add_development_dependency "rspec-rails", '~> 2.14.1'
  s.add_development_dependency 'mocha',       '~> 0.13.1'
  s.add_development_dependency 'guard-rspec', '~> 2.3.0'
  s.add_development_dependency 'guard-spork', '~> 1.5.0'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'confstruct',  '~> 0.2.5'
  s.add_development_dependency 'thor'
  s.add_development_dependency 'jasmine'
  s.add_development_dependency 'headless'
  s.add_development_dependency 'jquery-rails', '~> 2.2.0'
end
