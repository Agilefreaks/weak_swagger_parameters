# frozen_string_literal: true
module WeakSwaggerParameters
  module Definitions
    class Query < ParamContainer
      def string(name, description)
        @child_definitions << WeakSwaggerParameters::Definitions::QueryParams::String.new(name, description)
      end
    end
  end
end
