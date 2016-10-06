# frozen_string_literal: true
require 'spec_helper'

RSpec.describe 'Controller PATCH Documentation' do
  describe 'swagger doc' do
    subject { Swagger::Blocks.build_root_json([PatchTestsController]) }

    its(:as_json) { is_expected.to eq(JSON.parse(File.read('./spec/fixtures/documentation/patch_swagger.json'))) }
  end
end
