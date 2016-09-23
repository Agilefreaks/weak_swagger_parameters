# frozen_string_literal: true
module WeakSwaggerParameters
  module Definitions
    class Response
      def initialize(status_code, description)
        @status_code = status_code
        @description = description
      end

      def apply_validations(parent_node)
      end

      def apply_docs(parent_node)
        parent_node.response @status_code, description: @description
      end
    end
  end
end
