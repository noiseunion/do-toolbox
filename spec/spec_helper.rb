require 'rubygems'
require 'spork'
require 'active_support'
require 'digital_opera'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require 'rspec'
  require 'rspec/autorun'
  require 'mocha/api'

  # Configure RSpec ---------------------------------------
  RSpec.configure do |config|
    config.mock_with :mocha

    # Run specs in random order to surface order dependencies. If you find an
    # order dependency and want to debug it, you can fix the order by providing
    # the seed, which is printed after each run.
    #     --seed 1234
    config.order = "random"
  end
end

Spork.each_run do

end