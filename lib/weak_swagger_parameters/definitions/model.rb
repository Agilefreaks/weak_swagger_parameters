# frozen_string_literal: true
module WeakSwaggerParameters
  module Definitions
    class Model
      def initialize(model_name, &block)
        @model_name = model_name
        @required_fields = []
        @child_definitions = []

        instance_eval(&block) if block.present?
      end

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

      def apply_docs(parent_node)
        model_name = @model_name
        param_definitions = @child_definitions
        required_fields = @required_fields

        parent_node.instance_eval do
          swagger_schema model_name, required: required_fields do
            schema_node = self
            param_definitions.each { |definition| definition.apply_docs(schema_node) }
          end
        end
      end
    end
  end
end
