# frozen_string_literal: true
require 'spec_helper'

RSpec.describe 'Controller DELETE Documentation' do
  describe 'swagger doc' do
    subject { Swagger::Blocks.build_root_json([DeleteTestsController]) }

    its(:as_json) { is_expected.to eq(JSON.parse(File.read('./spec/fixtures/documentation/delete_swagger.json'))) }
  end
end
