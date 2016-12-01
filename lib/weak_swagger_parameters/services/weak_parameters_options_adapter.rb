# frozen_string_literal: true
module WeakSwaggerParameters
  module Services
    class WeakParametersOptionsAdapter
      MAX_VALUE = (2**(0.size * 8 - 2) - 1)
      MIN_VALUE = -(2**(0.size * 8 - 2))

      def self.adapt(options)
        result = {}
        result[:strong] = true
        result[:required] = options[:required]
        result[:only] = options[:enum] if options[:enum].present?
        result = result.merge(range_options(options))

        result
      end

      def self.range_options(options)
        return {} unless options.key?(:min) || options.key?(:max)

        max = options[:max] || MAX_VALUE
        min = options[:min] || MIN_VALUE
        { only: min...max }
      end
    end
  end
end
