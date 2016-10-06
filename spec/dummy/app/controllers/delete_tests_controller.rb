# frozen_string_literal: true
class DeleteTestsController < ActionController::Base
  include WeakSwaggerParameters::Controller

  add_to_doc_section('Test')

  swagger_root swagger: '2.0' do
    info version: '1.0', title: 'The test api', description: 'Test api description'
    key :host, 'localhost:1234'
    key :basePath, ''
    key :consumes, ['application/json']
    key :produces, ['application/json']
  end

  delete :destroy, '/tests/{id}', 'Deletes a test' do
    params do
      path do
        integer :id, 'Id of the test'
      end
    end
  end
  def destroy
    head 204
  end

  delete :destroy_context, '/tests/context', 'Deletes a context' do
    response 204, 'No content'
  end
  def destroy_context
    head 204
  end

  delete :destroy_shared_context, '/tests/shared_context', 'Deletes a shared context'
  def destroy_shared_context
    head 204
  end
end
