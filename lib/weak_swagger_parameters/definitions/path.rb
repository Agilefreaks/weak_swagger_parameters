# frozen_string_literal: true
module WeakSwaggerParameters
  module Definitions
    class Path < ParamContainer
      def string(name, description, options = {})
        register_definition(:string, name, description, options)
      end

      def integer(name, description, options = {})
        register_definition(:integer, name, description, options)
      end

      private

      def register_definition(type, name, description, options)
        @child_definitions << WeakSwaggerParameters::Definitions::Parameter.new(:path, type, name, description, options)
      end
    end
  end
end
