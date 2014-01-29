# lib/digital_opera/engine.rb

module DigitalOpera
  class Engine < Rails::Engine
    config.generators do |g|
      g.test_framework :rspec
    end
  end
end