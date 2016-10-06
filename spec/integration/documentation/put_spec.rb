# frozen_string_literal: true
require 'spec_helper'

RSpec.describe 'Controller PUT Documentation' do
  describe 'swagger doc' do
    subject { Swagger::Blocks.build_root_json([PutTestsController]) }

    its(:as_json) { is_expected.to eq(JSON.parse(File.read('./spec/fixtures/documentation/put_swagger.json'))) }
  end
end
