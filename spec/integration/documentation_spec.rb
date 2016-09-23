# frozen_string_literal: true
require 'spec_helper'

RSpec.describe 'Controller Action Documentation' do
  class TestsController < ActionController::Base
    include WeakSwaggerParameters::Controller

    add_to_doc_section('Test')

    swagger_root swagger: '2.0' do
      info version: '1.0', title: 'The test api', description: 'Test api description'
      key :host, 'localhost:1234'
      key :basePath, ''
      key :consumes, ['application/json']
      key :produces, ['application/json']
    end

    api :create, '/tests', 'Create test' do
      params do
        path do
          string :short_name, 'Short test name'
          integer :count, 'Count of tests'
        end
        query do
          string :token, 'The token'
        end
        body do
          string :subject, 'The unit under test'
          string :context, 'The context of the test'
          integer :runs, 'Run times'
          boolean :passed, 'Passed'
          boolean :boolean_required, 'Boolean required', required: true
          string :string_required, 'String required', required: true
          integer :integer_required, 'Integer required', required: true
          string :string_enum, 'String enum', enum: %w(a b c)
          string :string_default, 'String default', default: 'origin'
        end
      end

      response 201, 'Created the test'
      response 400, 'Bad Request'
    end
    def create
      head 201
    end
  end

  describe 'swagger doc' do
    subject { Swagger::Blocks.build_root_json([TestsController]) }

    its(:as_json) { is_expected.to eq(JSON.parse(File.read('./spec/fixtures/test_swagger.json'))) }
  end
end
