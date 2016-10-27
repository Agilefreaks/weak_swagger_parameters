# frozen_string_literal: true
module WeakSwaggerParameters
  module Definitions
    module PathParams
      class Integer
        def initialize(name, description)
          @name = name
          @description = description
        end

        def apply_validations(parent_node)
          name = @name

          parent_node.instance_eval do
            integer name, strong: true
          end
        end

        def apply_docs(parent_node)
          name = @name
          description = @description

          parent_node.instance_eval do
            parameter name: name, in: :path, required: true, description: description, type: :integer, format: :int32
          end
        end
      end
    end
  end
end
