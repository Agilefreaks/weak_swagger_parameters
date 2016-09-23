# frozen_string_literal: true
module WeakSwaggerParameters
  module Definitions
    class Body
      def initialize(&block)
        @child_definitions = []
        @required_fields = []
        instance_eval(&block)
      end

      def string(name, description, options = {})
        @required_fields << name if options.try(:[], :required)
        @child_definitions << WeakSwaggerParameters::Definitions::BodyParams::String.new(name, description, options)
      end

      def boolean(name, description, options = {})
        @required_fields << name if options.try(:[], :required)
        @child_definitions << WeakSwaggerParameters::Definitions::BodyParams::Boolean.new(name, description, options)
      end

      def integer(name, description, options = {})
        @required_fields << name if options.try(:[], :required)
        @child_definitions << WeakSwaggerParameters::Definitions::BodyParams::Integer.new(name, description, options)
      end

      def apply_validations(parent_node)
        @child_definitions.each { |definition| definition.apply_validations(parent_node) }
      end

      def apply_docs(parent_node)
        param_definitions = @child_definitions
        required_fields = @required_fields

        parent_node.instance_eval do
          parameter name: :body, in: :body, required: true do
            schema required: required_fields do
              schema_node = self
              param_definitions.each { |definition| definition.apply_docs(schema_node) }
            end
          end
        end
      end
    end
  end
end
