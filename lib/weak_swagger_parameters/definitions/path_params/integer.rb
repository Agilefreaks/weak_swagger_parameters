# frozen_string_literal: true
module WeakSwaggerParameters
  module Definitions
    module PathParams
      class Integer
        MIN_VALUE = -4611686018427387903
        MAX_VALUE = 4611686018427387903

        def initialize(name, description, options = nil)
          @name = name
          @description = description
          @options = options || {}
        end

        def apply_validations(parent_node)
          name = @name
          validation_options = { strong: true }
          validation_options = validation_options.merge(range_options)

          parent_node.instance_eval do
            integer name, validation_options
          end
        end

        def apply_docs(parent_node)
          name = @name
          description = @description
          docs_options = {
              name: name,
              in: :path,
              required: true,
              description: description,
              type: :integer,
              format: :int32
          }

          parent_node.instance_eval do
            parameter docs_options
          end
        end

        private
          def range_options
            max = @options[:max]
            min = @options[:min]
            result = {}

            if min.present?
              max ||= MAX_VALUE
            elsif max.present?
              min ||= MIN_VALUE
            end

            if min.present? && max.present?
              result[:only] = min...max
            end

            result
          end
      end
    end
  end
end
