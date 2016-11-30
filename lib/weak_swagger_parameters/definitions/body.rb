# frozen_string_literal: true
module WeakSwaggerParameters
  module Definitions
    class Body
      include WeakSwaggerParameters::Definitions::PropertyContainer

      def initialize(&block)
        instance_eval(&block) if block.present?
      end

      def apply_validations(parent_node)
        child_definitions.each { |definition| definition.apply_validations(parent_node) }
      end

      def apply_docs(parent_node)
        param_definitions = child_definitions
        schema_options = {}
        schema_options[:required] = required_fields unless required_fields.empty?

        parent_node.instance_eval do
          parameter name: :body, in: :body, required: true do
            schema schema_options do
              param_definitions.each { |definition| definition.apply_docs(self) }
            end
          end
        end
      end
    end
  end
end
