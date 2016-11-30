# frozen_string_literal: true
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
      }.freeze

      def self.adapt(options)
        result = {}
        result = result.merge(about_options(options))
        result = result.merge(enum_options(options))
        result = result.merge(default_options(options))
        result = result.merge(KNOWN_TYPES[options[:type]])
        result = result.merge(required_options(options))
        result = result.merge(range_options(options))
        result
      end

      def self.about_options(options)
        result = {}
        result = result.merge(name: options[:name]) if options[:name].present?
        result = result.merge(description: options[:description]) if options[:description].present?
        result = result.merge(in: options[:location]) if options[:location].present?
        result
      end

      def self.required_options(options)
        result = {}
        result = result.merge(required: true) if options[:location] == :path
        result = result.merge(required: options[:required]) if options[:required]
        result
      end

      def self.range_options(options)
        result = {}
        result = result.merge(minimum: options[:min]) if options[:min].present?
        result = result.merge(maximum: options[:max]) if options[:max].present?
        result
      end

      def self.default_options(options)
        options[:default].present? ? { default: options[:default] } : {}
      end

      def self.enum_options(options)
        options[:enum].present? ? { enum: options[:enum] } : {}
      end
    end
  end
end
