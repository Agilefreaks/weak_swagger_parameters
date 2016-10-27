# frozen_string_literal: true
module WeakSwaggerParameters
  module Model
    extend ActiveSupport::Concern

    module ClassMethods
      def add_to_doc_section(doc_section)
        @doc_sections ||= []
        @doc_sections << doc_section
      end

      def in_doc_section?(doc_section)
        (@doc_sections || []).include?(doc_section)
      end

      def model(&block)
        api_docs = WeakSwaggerParameters::Definitions::Model.new(docs_model_name, &block)
        api_docs.apply_docs(self)
      end

      def docs_model_name
        name.split('::').join('_')
      end
    end

    included do
      include Swagger::Blocks
    end
  end
end
