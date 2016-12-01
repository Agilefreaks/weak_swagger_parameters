# frozen_string_literal: true
module WeakSwaggerParameters
  module Services
    class WeakParametersOptionsAdapter
      MAX_VALUE = 4611686018427387903
      MIN_VALUE = -4611686018427387904

      def self.adapt(options)
        result = {}
        result[:strong] = true
        result[:required] = options[:required]
        result[:only] = options[:enum] if options[:enum].present?
        result = result.merge(range_options(options))

        result
      end

      def self.range_options(options)
        max = options[:max]
        min = options[:min]
        result = {}

        if min.present?
          max ||= MAX_VALUE
        elsif max.present?
          min ||= MIN_VALUE
        end

        result[:only] = min...max if min.present? && max.present?

        result
      end
    end
  end
end
