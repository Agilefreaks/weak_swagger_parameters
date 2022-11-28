# frozen_string_literal: true

module WeakSwaggerParameters
  module Definitions
    module PropertyContainer
      extend ActiveSupport::Concern

      included do
        def string(name, description, options = {})
          register_definition(name, options, WeakSwaggerParameters::Definitions::Property.new(:string, name, description, options))
        end

        def boolean(name, description, options = {})
          register_definition(name, options, WeakSwaggerParameters::Definitions::Property.new(:boolean, name, description, options))
        end

        def integer(name, description, options = {})
          register_definition(name, options, WeakSwaggerParameters::Definitions::Property.new(:integer, name, description, options))
        end

        def float(name, description, options = {})
          register_definition(name, options, WeakSwaggerParameters::Definitions::Property.new(:float, name, description, options))
        end

        def hash(name, description, options = {}, &block)
          register_definition(name, options, WeakSwaggerParameters::Definitions::HashProperty.new(name, description, &block))
        end

        def model(name, description, model_class, options = {})
          register_definition(name, options, WeakSwaggerParameters::Definitions::ModelProperty.new(name, description, model_class))
        end

        def array(name, description, options = {}, &block)
          item_type = options[:item_type] || block || (raise StandardError('missing :item_type option'))
          register_definition(name, options, WeakSwaggerParameters::Definitions::ArrayProperty.new(name, description, item_type, &block))
        end

        def collection(name, description, model_class, options = {})
          register_definition(name, options, WeakSwaggerParameters::Definitions::CollectionProperty.new(name, description, model_class))
        end

        private

        def register_definition(name, options, definition)
          required_fields << name if options.try(:[], :required)
          child_definitions << definition
        end

        def required_fields
          @required_fields ||= []
        end

        def child_definitions
          @child_definitions ||= []
        end
      end
    end
  end
end
