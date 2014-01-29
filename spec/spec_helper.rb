ENV["RAILS_ENV"] ||= 'test'

require 'rubygems'
require 'spork'

Spork.prefork do
  require File.expand_path("../dummy/config/environment.rb",  __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'mocha/api'

  require 'confstruct'

  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

  # Configure RSpec ---------------------------------------
  RSpec.configure do |config|
    config.mock_framework = :mocha

    # Run specs in random order to surface order dependencies. If you find an
    # order dependency and want to debug it, you can fix the order by providing
    # the seed, which is printed after each run.
    #     --seed 1234
    config.order = "random"
    # config.order = 63206
  end
end

Spork.each_run do

end