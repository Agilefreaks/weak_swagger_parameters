# frozen_string_literal: true

module WeakSwaggerParameters
  module Definitions
    module LeafDefinition
      def apply_validations(parent_node)
        type = @options[:type]
        name = @options[:name]

        validation_options = WeakSwaggerParameters::Services::WeakParametersOptionsAdapter.adapt(@options)
        parent_node.instance_eval { send type, name, validation_options }
      end
    end
  end
end
