# frozen_string_literal: true
module WeakSwaggerParameters
  module Definitions
    class Parameter
      def initialize(location, type, name, description, options = nil)
        @options = (options || {}).merge(location: location, type: type, name: name, description: description)
      end

      def apply_validations(parent_node)
        type = @options[:type]
        name = @options[:name]

        validation_options = WeakSwaggerParameters::Services::WeakParametersOptionsAdapter.adapt(@options)
        parent_node.instance_eval { send type, name, validation_options }
      end

      def apply_docs(parent_node)
        parameter_options = WeakSwaggerParameters::Services::SwaggerOptionsAdapter.adapt(@options)

        parent_node.instance_eval { parameter parameter_options }
      end
    end
  end
end
