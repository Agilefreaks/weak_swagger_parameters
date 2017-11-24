# frozen_string_literal: true

module WeakSwaggerParameters
  module Definitions
    class Parameter
      include WeakSwaggerParameters::Definitions::LeafDefinition

      def initialize(location, type, name, description, options = {})
        @options = options.merge(location: location, type: type, name: name, description: description)
      end

      def apply_docs(parent_node)
        parameter_options = WeakSwaggerParameters::Services::SwaggerOptionsAdapter.adapt(@options)

        parent_node.instance_eval { parameter parameter_options }
      end
    end
  end
end
