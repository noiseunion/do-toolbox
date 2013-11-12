#!/usr/bin/env rake

begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

Bundler::GemHelper.install_tasks

require 'rspec/core'
require 'rspec/core/rake_task'

Dir[File.join(File.dirname(__FILE__), 'tasks/**/*.rake')].each {|f| load f }

desc "Run all specs in spec directory (excluding plugin specs)"
RSpec::Core::RakeTask.new(:spec => 'app:db:test:prepare')
task :default => :spec
