# frozen_string_literal: true
module WeakSwaggerParameters
  module Definitions
    class Path < ParamContainer
      def string(name, description)
        @child_definitions << WeakSwaggerParameters::Definitions::PathParams::String.new(name, description)
      end

      def integer(name, description, options = nil)
        @child_definitions << WeakSwaggerParameters::Definitions::PathParams::Integer.new(name, description, options)
      end
    end
  end
end
