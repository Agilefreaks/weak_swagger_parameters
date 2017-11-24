# frozen_string_literal: true

module WeakSwaggerParameters
  module Controller
    extend ActiveSupport::Concern

    module ClassMethods
      def add_to_doc_section(doc_section)
        @doc_sections ||= []
        @doc_sections << doc_section
      end

      def in_doc_section?(doc_section)
        (@doc_sections || []).include?(doc_section)
      end

      def get(action, path, description, &block)
        api(:get, action, path, description, &block)
      end

      def post(action, path, description, &block)
        api(:post, action, path, description, &block)
      end

      def put(action, path, description, &block)
        api(:put, action, path, description, &block)
      end

      def patch(action, path, description, &block)
        api(:patch, action, path, description, &block)
      end

      def delete(action, path, description, &block)
        api(:delete, action, path, description, &block)
      end

      private

      def api(http_method, action, path, description, &block)
        api_docs = WeakSwaggerParameters::Definitions::Api.new(http_method, action, path, description, &block)
        api_docs.apply_validations(self)
        api_docs.apply_docs(self)
      end
    end

    included do
      extend WeakParameters::Controller
      include Swagger::Blocks

      rescue_from WeakParameters::ValidationError, with: :handle_param_validation_error

      def render_docs(docs_section)
        ensure_loaded
        render json: Swagger::Blocks.build_root_json(doc_components_for(docs_section))
      end

      def handle_param_validation_error(e)
        render json: { message: e.message }, status: 400
      end

      private

      def doc_components_for(docs_section)
        doc_components = []
        ObjectSpace.each_object(Class) do |klass|
          doc_components << klass if in_docs_section?(klass, docs_section)
        end
        doc_components
      end

      def ensure_loaded
        Rails.application.eager_load! if !Rails.configuration.eager_load || !Rails.configuration.cache_classes
      end

      def in_docs_section?(klass, docs_section)
        klass.methods.include?(:in_doc_section?) && klass.respond_to?(:in_doc_section?) && klass.in_doc_section?(docs_section)
      end
    end
  end
end
