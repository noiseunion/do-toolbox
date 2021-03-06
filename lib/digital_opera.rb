require "digital_opera/engine"
require "digital_opera/token"
require "digital_opera/base_extensions/object"
require "digital_opera/banker"
require "digital_opera/presenter"
require "digital_opera/document"
require "digital_opera/form_object"

if defined?(AWS)
  require "digital_opera/services/s3"
end

module DigitalOpera
end