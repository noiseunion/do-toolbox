# lib/digital_opera/form_object/base.rb

module DigitalOpera
  module FormObject
    class Base
      # ActiveModel plumbing to make `form_for` work
      extend ActiveModel::Naming
      include ActiveModel::Conversion
      include ActiveModel::Validations

      class << self
        attr_accessor :fields
      end

      def initialize(h={})
        assign_attributes(h)
      end

      def persisted?
        false
      end

      def save
        if valid?
          persist!
        else
          false
        end
      end

      def assign_attributes(args)
        args.each do |k,v|
          if respond_to?("#{k}=")
            send("#{k}=", v)
          end
        end
      end

      def fields
        self.class.ancestors.map do |a|
          a.fields if a.respond_to? :fields
        end.flatten.compact
      end

      # Class Methods ----------------------------

      def self.field(*args, options)
        if options.present? && !options.is_a?(Hash)
          args << options
        end

        args.each do |field|
          if options.is_a?(Hash) && options[:date] == true
            date_field(field)
          else
            send :attr_accessor, field
          end

          add_to_fields field
        end
      end

      def self.add_to_fields(field)
        @fields = @fields || []
        @fields << field
      end

      private # ---------------------------------------------

      # overwrite on subclasses
      def persist!
        raise NotImplementedError
      end

      def self.date_field(field)
        # create a getter that gets the date and converts it to strftime
        send :define_method, field do
          if instance_variable_get("@#{field}").present?
            date = instance_variable_get("@#{field}")
            begin
              date.strftime('%m/%d/%Y')
            rescue
              date
            end
          end
        end

        # setter for date
        send :define_method, "#{field}=" do |date|
          if date.is_a? String
            begin
              d = date.gsub(' ', '')
              new_date = Date.parse(d)
            rescue
              new_date = date
            end
          else
            new_date = date
          end

          instance_variable_set("@#{field}", new_date)
        end

        send :define_method, "valid_#{field}" do
          begin
            val = send(field)
            val.is_a?(Date) || Date.parse(val)
          rescue
            errors.add(field.to_sym, 'is not a valid date')
          end
        end
      end
    end
  end
end