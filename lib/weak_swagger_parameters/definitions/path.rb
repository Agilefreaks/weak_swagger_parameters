# frozen_string_literal: true
module WeakSwaggerParameters
  module Definitions
    class Path < ParamContainer
      def string(name, description)
        @child_definitions << WeakSwaggerParameters::Definitions::PathParams::String.new(name, description)
      end

      def integer(name, description)
        @child_definitions << WeakSwaggerParameters::Definitions::PathParams::Integer.new(name, description)
      end
    end
  end
end
