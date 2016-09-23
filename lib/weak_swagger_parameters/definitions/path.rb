# frozen_string_literal: true
module WeakSwaggerParameters
  module Definitions
    class Path
      def initialize(&block)
        @child_definitions = []
        instance_eval(&block)
      end

      def string(name, description)
        @child_definitions << WeakSwaggerParameters::Definitions::PathParams::String.new(name, description)
      end

      def integer(name, description)
        @child_definitions << WeakSwaggerParameters::Definitions::PathParams::Integer.new(name, description)
      end

      def apply_validations(parent_node)
        @child_definitions.each { |definition| definition.apply_validations(parent_node) }
      end

      def apply_docs(parent_node)
        @child_definitions.each { |definition| definition.apply_docs(parent_node) }
      end
    end
  end
end
