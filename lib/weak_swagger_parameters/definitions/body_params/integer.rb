# frozen_string_literal: true
module WeakSwaggerParameters
  module Definitions
    module BodyParams
      class Integer
        def initialize(name, description, options)
          @name = name
          @description = description
          @options = options
        end

        def apply_validations(parent_node)
          name = @name
          options = @options

          parent_node.instance_eval do
            integer_options = {}
            integer_options[:strong] = true
            integer_options[:required] = !!options[:required]
            integer_options[:only] = options[:enum] if options.key?(:enum)
            integer name, integer_options
          end
        end

        def apply_docs(parent_node)
          name = @name
          description = @description

          parent_node.instance_eval do
            property name, type: :integer, format: :int32, description: description
          end
        end
      end
    end
  end
end
