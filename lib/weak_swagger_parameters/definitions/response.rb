# frozen_string_literal: true

module WeakSwaggerParameters
  module Definitions
    class Response
      def initialize(status_code, description, &block)
        @status_code = status_code
        @description = description
        @content_schema = nil

        instance_eval(&block) if block.present?
      end

      def hash(&block)
        @content_schema = WeakSwaggerParameters::Definitions::HashRef.new(&block)
      end

      def model(model_class)
        @content_schema = WeakSwaggerParameters::Definitions::ModelRef.new(model_class)
      end

      def collection(model_class)
        @content_schema = WeakSwaggerParameters::Definitions::CollectionRef.new(model_class)
      end

      def apply_docs(parent_node)
        status_code = @status_code
        response_options = { description: @description }
        content_schema = @content_schema

        parent_node.instance_eval do
          response status_code, response_options do
            response_node = self

            content_schema.apply_docs(response_node) if content_schema.present?
          end
        end
      end
    end
  end
end
