module WeakSwaggerParameters
  module Services
    class WeakParametersOptionsAdapter
      def self.adapt(options)
        result = {}
        result[:strong] = true
        result[:required] = !!options[:required]
        result[:only] = options[:enum] if options[:enum].present?
        result = result.merge(range_options(options))

        result
      end

      private

      def self. range_options(options)
        max = options[:max]
        min = options[:min]
        result = {}

        if min.present?
          max ||= MAX_VALUE
        elsif max.present?
          min ||= MIN_VALUE
        end

        if min.present? && max.present?
          result[:only] = min...max
        end

        result
      end
    end
  end
end
