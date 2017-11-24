# frozen_string_literal: true

module WeakSwaggerParameters
  module Definitions
    class HashProperty
      include WeakSwaggerParameters::Definitions::PropertyContainer

      def initialize(name, description, &block)
        @name = name
        @description = description

        instance_eval(&block) if block.present?
      end

      def apply_validations(parent_node)
        name = @name
        param_definitions = child_definitions

        parent_node.instance_eval do
          hash name, strong: true do
            param_definitions.each { |definition| definition.apply_validations(parent_node) }
          end
        end
      end

      def apply_docs(parent_node)
        name = @name
        description = @description
        definitions = child_definitions

        parent_node.instance_eval do
          property name, description: description, type: :object do
            hash_node = self
            definitions.each { |definition| definition.apply_docs(hash_node) }
          end
        end
      end
    end
  end
end
