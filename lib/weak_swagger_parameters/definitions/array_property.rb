# frozen_string_literal: true

module WeakSwaggerParameters
  module Definitions
    class ArrayProperty
      include WeakSwaggerParameters::Definitions::PropertyContainer

      def initialize(name, description, item_type, &block)
        @name = name
        @description = description
        @item_type = item_type

        instance_eval(&block) if block.present?
      end

      def apply_validations(parent_node)
        name = @name

        parent_node.instance_eval do
          array name
        end
      end

      def apply_docs(parent_node)
        name = @name
        description = @description
        item_type = @item_type
        definitions = child_definitions

        parent_node.instance_eval do
          schema_node = Swagger::Blocks::SchemaNode.call(version: version, inline_keys: nil)
          definitions.each { |definition| definition.apply_docs(schema_node) }

          property name, description: description, type: :array do
            items do
              if definitions.any?
                key :type, :object
                key :properties, schema_node.as_json[:properties]
              else
                key :type, item_type
              end
            end
          end
        end
      end
    end
  end
end
