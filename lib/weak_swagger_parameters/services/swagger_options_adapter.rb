module WeakSwaggerParameters
  module Services
    class SwaggerOptionsAdapter
      KNOWN_TYPES = {
          integer: { type: :integer, format: :int32 },
          long: { type: :integer, format: :int64 },
          float: { type: :number, format: :float },
          double: { type: :number, format: :double },
          string: { type: :string },
          byte: { type: :string, format: :byte },
          binary: { type: :string, format: :binary },
          boolean: { type: :boolean },
          date: { type: :string, format: :date },
          dateTime: { type: :string, format: :'date-time' },
          password: { type: :string, format: :password }
      }

      def self.adapt(options)
        result = {}
        result = result.merge(name: options[:name]) if options[:name].present?
        result = result.merge(in: options[:location]) if options[:location].present?
        result = result.merge(required: true) if options[:location] == :path
        result = result.merge(required: options[:required]) if !!options[:required]
        result = result.merge(description: options[:description]) if options[:description].present?
        result = result.merge(default: options[:default]) if options[:default].present?
        result = result.merge(enum: options[:enum]) if options[:enum].present?
        result = result.merge(KNOWN_TYPES[options[:type]])
        result = result.merge(minimum: options[:min]) if options[:min].present?
        result = result.merge(maximum: options[:max]) if options[:max].present?
        result
      end
    end
  end
end