# frozen_string_literal: true
module WeakSwaggerParameters
  module Definitions
    module QueryParams
      class String
        def initialize(name, description)
          @name = name
          @description = description
        end

        def apply_validations(parent_node)
          name = @name

          parent_node.instance_eval do
            string name, strong: true
          end
        end

        def apply_docs(parent_node)
          name = @name
          description = @description

          parent_node.instance_eval do
            parameter name: name, type: :string, in: :query, description: description
          end
        end
      end
    end
  end
end
