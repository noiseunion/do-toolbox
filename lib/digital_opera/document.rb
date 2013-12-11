## Tableless models designed to work in a similar fashion to how
## a Mongoid document works
require_relative "document/fields/standard"

module DigitalOpera
  module Document
    extend ActiveSupport::Concern

    included do
      class_attribute :fields

      self.fields = {}
    end

    def attribute_names
      self.class.fields.keys.reject{ |k| !respond_to?(k) }
    end

    module ClassMethods
      # Defines all the fields that are accessible on the Document
      # For each field that is defined, a getter and setter will be
      # added as an instance method to the Document.
      #
      # @example Define a field.
      #   field :score, :type => Integer, :default => 0
      #
      # @param [ Symbol ] name The name of the field.
      # @param [ Hash ] options The options to pass to the field.
      #
      # @return [ Field ] The generated field
      def field(name, options = {})
        named = name.to_s
        added = add_field(named, options)
        descendants.each do |subclass|
          subclass.add_field(named, options)
        end
        added
      end

      protected # -----------------------------------------

      # Create the field accessors.
      #
      # @example Generate the accessors.
      #   Person.create_accessors(:name, "name")
      #   person.name #=> returns the field
      #   person.name = "" #=> sets the field
      #   person.name? #=> Is the field present?
      #   person.name_before_type_cast #=> returns the field before type cast
      #
      # @param [ Symbol ] name The name of the field.
      # @param [ Symbol ] meth The name of the accessor.
      # @param [ Hash ] options The options.
      #
      # @since 2.0.0
      def create_accessors(name, meth, options = {})
        field = fields[name]
        create_field_getter(name, meth, field)
        create_field_setter(name, meth, field)
      end

      # Create the getter method for the provided field.
      #
      # @example Create the getter.
      #   Model.create_field_getter("name", "name", field)
      #
      # @param [ String ] name The name of the attribute.
      # @param [ String ] meth The name of the method.
      # @param [ Field ] field The field.
      #
      # @since 2.4.0
      def create_field_getter(name, meth, field)
        generated_methods.module_eval do
          define_method("#{ meth }") do
            value = instance_variable_get "@#{ name }"
            value.nil? ? field.default_val : value
          end
        end
      end

      def generated_methods
        @generated_methods ||= begin
          mod = Module.new
          include(mod)
          mod
        end
      end

      # Create the setter method for the provided field.
      #
      # @example Create the setter.
      #   Model.create_field_setter("name", "name")
      #
      # @param [ String ] name The name of the attribute.
      # @param [ String ] meth The name of the method.
      # @param [ Field ] field The field.
      #
      # @since 2.4.0
      def create_field_setter(name, meth, field)
        generated_methods.module_eval do
          define_method("#{ meth }=") do |value|
            instance_variable_set "@#{ name }", value
          end
        end
      end

      # Add the defaults to the model. This breaks them up between ones that
      # are procs and ones that are not.
      #
      # @example Add to the defaults.
      #   Model.add_defaults(field)
      #
      # @param [ Field ] field The field to add for.
      #
      # @since 2.4.0
      def add_defaults(field)
        default, name = field.default_val, field.name.to_s
        remove_defaults(name)
        unless default.nil?
          if field.pre_processed?
            pre_processed_defaults.push(name)
          else
            post_processed_defaults.push(name)
          end
        end
      end

      # Define a field attribute for the +Document+.
      #
      # @example Set the field.
      #   Person.add_field(:name, :default => "Test")
      #
      # @param [ Symbol ] name The name of the field.
      # @param [ Hash ] options The hash of options.
      def add_field(name, options = {})
        # aliased = options[:as]
        # aliased_fields[aliased.to_s] = name if aliased
        field         = field_for(name, options)
        fields[name]  = field
        # add_defaults(field)
        create_accessors(name, name, options)
        # process_options(field)
        # create_dirty_methods(name, name)
        # create_dirty_methods(name, aliased) if aliased
        field
      end

      # Remove the default keys for the provided name.
      #
      # @example Remove the default keys.
      #   Model.remove_defaults(name)
      #
      # @param [ String ] name The field name.
      #
      # @since 2.4.0
      def remove_defaults(name)
        pre_processed_defaults.delete_one(name)
        post_processed_defaults.delete_one(name)
      end

      def field_for(name, options)
        opts = options.merge(klass: self)
        Fields::Standard.new(name, opts)
      end
    end
  end
end