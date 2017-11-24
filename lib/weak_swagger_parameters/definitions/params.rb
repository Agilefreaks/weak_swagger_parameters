# frozen_string_literal: true

module WeakSwaggerParameters
  module Definitions
    class Params < ParamContainer
      def initialize(&block)
        @child_definitions = []
        instance_eval(&block)
      end

      def body(&block)
        @child_definitions << WeakSwaggerParameters::Definitions::Body.new(&block)
      end

      def query(&block)
        @child_definitions << WeakSwaggerParameters::Definitions::Query.new(&block)
      end

      def path(&block)
        @child_definitions << WeakSwaggerParameters::Definitions::Path.new(&block)
      end
    end
  end
end
