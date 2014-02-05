# lib/digital_opera/presenter/concerns/json_serialization.rb

module DigitalOpera
  module Presenter
    module JsonSerialization
      extend ActiveSupport::Concern

      def as_json(opts={})
        super(opts).merge( self.get_json_field_hash )
      end

      def get_json_field_hash
        json_field_hash = {}

        self.class.include_in_json.each do |method_name|
          json_field_hash[method_name.to_sym] = self.send(method_name)
        end

        json_field_hash
      end

      module ClassMethods
        def include_in_json(*method_names)
          return @json_method_names if method_names.empty?
          @json_method_names = method_names
        end
      end
    end
  end
end