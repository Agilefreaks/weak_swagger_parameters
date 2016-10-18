# frozen_string_literal: true
module WeakSwaggerParameters
  module Definitions
    class HashRef
      include WeakSwaggerParameters::Definitions::PropertyContainer

      def initialize(&block)
        instance_eval(&block) if block.present?
      end

      def apply_docs(parent_node)
        definitions = child_definitions

        parent_node.instance_eval do
          schema do
            definitions.each { |definition| definition.apply_docs(self) }
          end
        end
      end
    end
  end
end
