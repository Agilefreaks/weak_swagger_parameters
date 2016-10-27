# frozen_string_literal: true
module WeakSwaggerParameters
  module Definitions
    module PropertyContainer
      extend ActiveSupport::Concern

      included do
        def string(name, description, options = {})
          @required_fields << name if options.try(:[], :required)
          @child_definitions << WeakSwaggerParameters::Definitions::Property.new(:string, name, description, options)
        end

        def boolean(name, description, options = {})
          @required_fields << name if options.try(:[], :required)
          @child_definitions << WeakSwaggerParameters::Definitions::Property.new(:boolean, name, description, options)
        end

        def integer(name, description, options = {})
          @required_fields << name if options.try(:[], :required)
          @child_definitions << WeakSwaggerParameters::Definitions::Property.new(:integer, name, description, options)
        end

        def hash(name, description, options = {}, &block)
          @required_fields << name if options.try(:[], :required)
          @child_definitions << WeakSwaggerParameters::Definitions::HashProperty.new(name, description, &block)
        end

        def model(name, description, model_class, options = {})
          @required_fields << name if options.try(:[], :required)
          @child_definitions << WeakSwaggerParameters::Definitions::ModelProperty.new(name, description, model_class)
        end

        def collection(name, description, model_class, options = {})
          @required_fields << name if options.try(:[], :required)
          @child_definitions << WeakSwaggerParameters::Definitions::CollectionProperty.new(name, description, model_class)
        end
      end
    end
  end
end
