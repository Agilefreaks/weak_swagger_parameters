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
          validation_options = validation_options.merge(range_validation_options)

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
          docs_options = docs_options.merge(range_docs_options)

          parent_node.instance_eval do
            parameter docs_options
          end
        end

        private
          def range_validation_options
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

          def range_docs_options
            max = @options[:max]
            min = @options[:min]
            result = {}

            if min.present?
              result[:minimum] = min
            end
            if max.present?
              result[:maximum] = max
            end

            result
          end
      end
    end
  end
end
