# frozen_string_literal: true
module WeakSwaggerParameters
  module Definitions
    class Property
      include WeakSwaggerParameters::Definitions::LeafDefinition

      def initialize(type, name, description, options = {})
        @options = options.merge(name: name, type: type, description: description)
      end

      def apply_docs(parent_node)
        name = @options[:name]
        property_options = WeakSwaggerParameters::Services::SwaggerOptionsAdapter.adapt(@options.except(:name, :required))

        parent_node.instance_eval { property name, property_options }
      end
    end
  end
end
