# frozen_string_literal: true
module WeakSwaggerParameters
  module Definitions
    class Api
      def initialize(method, path, summary, &block)
        @method = method
        @path = path
        @summary = summary
        @child_definitions = []
        @description = nil

        instance_eval(&block)
      end

      def description(description)
        @description = description
      end

      def params(&block)
        @child_definitions << WeakSwaggerParameters::Definitions::Params.new(&block)
      end

      def response(status_code, description)
        @child_definitions << WeakSwaggerParameters::Definitions::Response.new(status_code, description)
      end

      def apply_validations(controller_class)
        child_definitions = @child_definitions
        method = @method

        controller_class.instance_eval do
          validates method do
            child_definitions.each { |definition| definition.apply_validations(self) }
          end
        end
      end

      def apply_docs(controller_class)
        child_definitions = @child_definitions
        summary = @summary
        description = @description
        method = http_method
        path = @path
        name = controller_class.controller_name.humanize

        controller_class.instance_eval do
          swagger_path path do
            operation method, operationId: "#{method}#{name}", summary: summary do
              child_definitions.each { |definition| definition.apply_docs(self) }
              key :description, description unless description.blank?
              key :tags, [name]
            end
          end
        end
      end

      private

      def http_method
        {
          create: :post,
          index: :get,
          show: :get,
          destroy: :delete,
          update: :put
        }[@method]
      end
    end
  end
end
