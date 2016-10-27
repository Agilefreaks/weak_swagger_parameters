# frozen_string_literal: true
module WeakSwaggerParameters
  module Definitions
    class HashProperty
      def initialize(name, description, &block)
        @name = name
        @description = description
        @child_definitions = []

        instance_eval(&block) if block.present?
      end

      def string(name, description, options = {})
        @child_definitions << WeakSwaggerParameters::Definitions::Property.new(:string, name, description, options)
      end

      def boolean(name, description, options = {})
        @child_definitions << WeakSwaggerParameters::Definitions::Property.new(:boolean, name, description, options)
      end

      def integer(name, description, options = {})
        @child_definitions << WeakSwaggerParameters::Definitions::Property.new(:integer, name, description, options)
      end

      def hash(name, description, &block)
        @child_definitions << WeakSwaggerParameters::Definitions::HashProperty.new(name, description, &block)
      end

      def model(name, description, model_class)
        @child_definitions << WeakSwaggerParameters::Definitions::ModelProperty.new(name, description, model_class)
      end

      def collection(name, description, model_class)
        @child_definitions << WeakSwaggerParameters::Definitions::CollectionProperty.new(name, description, model_class)
      end

      def apply_docs(parent_node)
        name = @name
        description = @description
        child_definitions = @child_definitions

        parent_node.instance_eval do
          property name, description: description, type: :object do
            hash_node = self
            child_definitions.each { |definition| definition.apply_docs(hash_node) }
          end
        end
      end
    end
  end
end
