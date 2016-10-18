# frozen_string_literal: true
module WeakSwaggerParameters
  module Definitions
    class Property
      def initialize(type, name, description, options = {})
        @type = type
        @name = name
        @description = description
        @options = options || {}
      end

      def apply_docs(parent_node)
        name = @name
        property_options = { description: @description }
        property_options[:default] = @options[:default] if @options.key?(:default)
        property_options[:enum] = @options[:enum] if @options.key?(:enum)
        property_options.merge!(swagger_type_options)

        parent_node.instance_eval { property name, property_options }
      end

      private

      # rubocop:disable MethodLength
      def swagger_type_options
        known_types = {
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

        known_types[@type]
      end
    end
  end
end
