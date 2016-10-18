# frozen_string_literal: true
module WeakSwaggerParameters
  module Definitions
    class ModelRef
      def initialize(model_class)
        @model_class = model_class
      end

      def apply_docs(parent_node)
        model_class = @model_class

        parent_node.instance_eval do
          schema do
            key :'$ref', model_class.docs_model_name
          end
        end
      end
    end
  end
end
