# frozen_string_literal: true

module WeakSwaggerParameters
  module Definitions
    class CollectionProperty
      def initialize(name, description, model_class)
        @name = name
        @description = description
        @model_class = model_class
      end

      def apply_docs(parent_node)
        name = @name
        description = @description
        model_class = @model_class

        parent_node.instance_eval do
          property name, description: description, type: :array do
            items do
              key :'$ref', model_class.docs_model_name
            end
          end
        end
      end

      def apply_validations(_parent_node)
        # TODO: figure out how to write a spec & validation for this
      end
    end
  end
end
