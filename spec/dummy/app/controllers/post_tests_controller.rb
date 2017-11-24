# frozen_string_literal: true

class PostTestsController < ActionController::Base
  include WeakSwaggerParameters::Controller

  add_to_doc_section('Test')

  swagger_root swagger: '2.0' do
    info version: '1.0', title: 'The test api', description: 'Test api description'
    key :host, 'localhost:1234'
    key :basePath, '/'
    key :consumes, ['application/json']
    key :produces, ['application/json']
  end

  post :create, '/tests', 'Create test' do
    params do
      path do
        string :short_name, 'Short test name'
        integer :count, 'Count of tests', min: 1, max: 100
        string :path_enum, 'Path enum', enum: %w[a b c]
      end
      query do
        string :token, 'The token'
        string :type, 'The type', enum: %w[a b c]
      end
      body do
        string :subject, 'The unit under test'
        string :context, 'The context of the test'
        integer :runs, 'Run times'
        integer :position, 'Start Position', min: 1, max: 100
        boolean :passed, 'Passed'
        boolean :boolean_required, 'Boolean required', required: true
        string :string_required, 'String required', required: true
        integer :integer_required, 'Integer required', required: true
        float :float_required, 'Float required', required: true
        string :string_enum, 'String enum', enum: %w[a b c]
        string :string_default, 'String default', default: 'origin'
        integer :min_missing, 'Min missing', max: 100
        integer :max_missing, 'Max missing', min: 1
        model :nested_model, 'My nested model', ModelChildResponse
        hash :my_hash, 'my hash' do
          string :nested_string, 'Nested string'
        end
      end
    end

    response 201, 'Created the test'
    response 400, 'Bad Request'
  end
  def create
    head 201
  end

  post :custom_action, '/tests/custom_action', 'Creates a custom action' do
    params do
      body do
        string :action, 'Some action'
      end
    end

    response 201
  end
  def custom_action
    head 201
  end
end
