# frozen_string_literal: true
class ModelResponsesController < ActionController::Base
  include WeakSwaggerParameters::Controller

  add_to_doc_section('Test')

  swagger_root swagger: '2.0' do
    info version: '1.0', title: 'The test api', description: 'Test api description'
    key :host, 'localhost:1234'
    key :basePath, ''
    key :consumes, ['application/json']
    key :produces, ['application/json']
  end

  get :show, '/tests/show', 'Show suite' do
    response 200, 'A ModelResponse' do
      model ModelResponse
    end
  end
  def show
    head 200
  end

  get :index, '/tests/index', 'List suites' do
    response 200, 'An array of ModelResponse' do
      collection ModelResponse
    end
  end
  def index
    head 200
  end
end
