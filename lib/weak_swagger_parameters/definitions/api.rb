# frozen_string_literal: true
module WeakSwaggerParameters
  module Definitions
    class Api
      attr_reader :path

      def initialize(http_method, action, path, summary, &block)
        @http_method = http_method
        @action = action
        @path = path
        @summary = summary
        @param_definition = nil
        @response_definitions = []
        @description = nil

        instance_eval(&block)
      end

      def description(description)
        @description = description
      end

      def params(&block)
        @param_definition = WeakSwaggerParameters::Definitions::Params.new(&block)
      end

      def response(status_code, description)
        @response_definitions << WeakSwaggerParameters::Definitions::Response.new(status_code, description)
      end

      def apply_validations(controller_class)
        child_definitions = validation_definitions
        action = @action

        controller_class.instance_eval do
          validates action do
            child_definitions.each { |definition| definition.apply_validations(self) }
          end
        end
      end

      def apply_docs(controller_class)
        this = self
        http_method = @http_method
        operation_params = operation_params(http_method, controller_class)

        controller_class.instance_eval do
          swagger_path this.path do
            operation http_method, operation_params do
              this.child_definitions.each { |definition| definition.apply_docs(self) }
            end
          end
        end
      end

      def child_definitions
        validation_definitions + @response_definitions
      end

      private

      def validation_definitions
        [@param_definition]
      end

      def operation_params(method, controller_class)
        name = resource_name(controller_class)
        {
          summary: @summary,
          operationId: operation_id(method, name),
          tags: [name]
        }.tap do |h|
          h[:description] = @description unless @description.blank?
        end
      end

      def resource_name(controller_class)
        controller_class.controller_name.humanize
      end

      def operation_id(method, name)
        "#{method}#{name}"
      end
    end
  end
end
