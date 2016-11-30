# frozen_string_literal: true
module WeakSwaggerParameters
  module Definitions
    class Model
      include WeakSwaggerParameters::Definitions::PropertyContainer

      def initialize(model_name, &block)
        @model_name = model_name

        instance_eval(&block) if block.present?
      end

      def apply_validations(parent_node)
        child_definitions.each { |definition| definition.apply_validations(parent_node) }
      end

      def apply_docs(parent_node)
        model_name = @model_name
        definitions = child_definitions
        schema_options = {}
        schema_options[:required] = required_fields unless required_fields.empty?

        parent_node.instance_eval do
          swagger_schema model_name, schema_options do
            schema_node = self
            definitions.each { |definition| definition.apply_docs(schema_node) }
          end
        end
      end
    end
  end
end
