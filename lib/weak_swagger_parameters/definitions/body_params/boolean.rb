# frozen_string_literal: true
module WeakSwaggerParameters
  module Definitions
    module BodyParams
      class Boolean
        def initialize(name, description, options)
          @name = name
          @description = description
          @options = options
        end

        def apply_validations(parent_node)
          name = @name

          parent_node.instance_eval do
            boolean name, strong: true
          end
        end

        def apply_docs(parent_node)
          name = @name
          description = @description

          parent_node.instance_eval do
            property name, type: :boolean, description: description
          end
        end
      end
    end
  end
end
