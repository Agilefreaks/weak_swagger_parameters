# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Controller POST Documentation' do
  describe 'swagger doc' do
    subject { Swagger::Blocks.build_root_json([PostTestsController]) }

    its(:as_json) { is_expected.to eq(JSON.parse(File.read('./spec/fixtures/documentation/post_swagger.json'))) }

    it 'generates valid schema' do
      schema_path = './spec/fixtures/swagger_2_0_schema.json'

      swagger_json = subject.to_json

      expect(JSON::Validator.fully_validate(schema_path, swagger_json)).to be_empty
    end
  end
end
