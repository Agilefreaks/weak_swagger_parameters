# frozen_string_literal: true
require 'spec_helper'

RSpec.describe 'Model Response Documentation' do
  describe 'swagger doc' do
    subject { Swagger::Blocks.build_root_json([ModelResponsesController, ModelResponse]) }

    its(:as_json) { is_expected.to eq(JSON.parse(File.read('./spec/fixtures/documentation/model_responses_swagger.json'))) }
  end
end
