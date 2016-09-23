# frozen_string_literal: true
module WeakSwaggerParameters
  module Definitions
    class Response
      def initialize(status_code, description)
        @status_code = status_code
        @description = description
      end

      def apply_docs(parent_node)
        status_code = @status_code
        response_options = { description: @description }

        parent_node.instance_eval do
          response status_code, response_options
        end
      end
    end
  end
end
