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

      def api(method, path, description, &block)
        api_docs = WeakSwaggerParameters::Definitions::Api.new(method, path, description, &block)
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
        controllers = controllers_in_docs_section(docs_section)

        render json: Swagger::Blocks.build_root_json(controllers)
      end

      def handle_param_validation_error(e)
        render json: { message: e.message }, status: 400
      end

      private

        def controllers_in_docs_section(docs_section)
          controllers = []
          ObjectSpace.each_object(Class) do |klass|
            if is_controller?(klass) && is_in_docs_section?(klass, docs_section)
              controllers << klass
            end
          end
          controllers
        end

        def ensure_loaded
          Rails.application.eager_load! if !Rails.configuration.eager_load || !Rails.configuration.cache_classes
        end

        def is_controller?(klass)
          klass.ancestors.include?(AbstractController::Base)
        end

        def is_in_docs_section?(klass, docs_section)
          klass.respond_to?(:in_doc_section?) && klass.in_doc_section?(docs_section)
        end
    end
  end
end
