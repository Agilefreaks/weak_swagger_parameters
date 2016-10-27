# frozen_string_literal: true
module WeakSwaggerParameters
  module Definitions
    class HashProperty
      include WeakSwaggerParameters::Definitions::PropertyContainer

      def initialize(name, description, &block)
        @name = name
        @description = description
        @required_fields = []
        @child_definitions = []

        instance_eval(&block) if block.present?
      end

      def apply_docs(parent_node)
        name = @name
        description = @description
        child_definitions = @child_definitions

        parent_node.instance_eval do
          property name, description: description, type: :object do
            hash_node = self
            child_definitions.each { |definition| definition.apply_docs(hash_node) }
          end
        end
      end
    end
  end
end
