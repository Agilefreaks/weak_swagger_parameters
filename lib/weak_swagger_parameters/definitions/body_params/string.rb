# frozen_string_literal: true
module WeakSwaggerParameters
  module Definitions
    module BodyParams
      class String
        def initialize(name, description, options = {})
          @name = name
          @description = description
          @options = options || {}
        end

        def apply_validations(parent_node)
          name = @name
          options = @options

          parent_node.instance_eval do
            string_options = {}
            string_options[:strong] = true
            string_options[:required] = !!options[:required]
            string_options[:only] = options[:enum] if options.key?(:enum)
            string name, string_options
          end
        end

        def apply_docs(parent_node)
          name = @name
          description = @description
          options = @options

          parent_node.instance_eval do
            property name, type: :string, description: description do
              key :default, options[:default] if options.key?(:default)
              key :enum, options[:enum] if options.key?(:enum)
            end
          end
        end
      end
    end
  end
end
