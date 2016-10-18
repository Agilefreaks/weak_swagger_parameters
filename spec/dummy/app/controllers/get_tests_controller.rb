# frozen_string_literal: true
class GetTestsController < ActionController::Base
  include WeakSwaggerParameters::Controller

  add_to_doc_section('Test')

  swagger_root swagger: '2.0' do
    info version: '1.0', title: 'The test api', description: 'Test api description'
    key :host, 'localhost:1234'
    key :basePath, '/'
    key :consumes, ['application/json']
    key :produces, ['application/json']
  end

  get :index, '/tests', 'List tests' do
    params do
      query do
        string :term, 'Search term'
      end
    end

    response 200, 'A list of tests'
  end
  def index
    []
  end

  get :show, '/tests/show', 'Show suite' do
    response 200, 'No content.'
  end
  def ignore_test
    head 200
  end
end
