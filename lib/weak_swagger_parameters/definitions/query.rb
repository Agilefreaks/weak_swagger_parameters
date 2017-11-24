# frozen_string_literal: true

module WeakSwaggerParameters
  module Definitions
    class Query < ParamContainer
      def string(name, description, options = {})
        @child_definitions << WeakSwaggerParameters::Definitions::Parameter.new(:query, :string, name, description, options)
      end
    end
  end
end
