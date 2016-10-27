# frozen_string_literal: true
module WeakSwaggerParameters
  module Definitions
    class Body < ParamContainer
      def initialize(&block)
        @required_fields = []
        super
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
        param_definitions = @child_definitions
        schema_options = {}
        schema_options[:required] = @required_fields unless @required_fields.empty?

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
