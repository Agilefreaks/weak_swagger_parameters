# frozen_string_literal: true
module WeakSwaggerParameters
  module Definitions
    class Response
      def initialize(status_code, description, &block)
        @status_code = status_code
        @description = description
        @model_schema = nil

        instance_eval(&block) if block.present?
      end

      def model(model_class)
        @model_schema = WeakSwaggerParameters::Definitions::ModelRef.new(model_class)
      end

      def apply_docs(parent_node)
        status_code = @status_code
        response_options = { description: @description }
        model_schema = @model_schema

        parent_node.instance_eval do
          response status_code, response_options do
            response_node = self

            model_schema.apply_docs(response_node) if model_schema.present?
          end
        end
      end
    end
  end
end
