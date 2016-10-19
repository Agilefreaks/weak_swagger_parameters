# frozen_string_literal: true
class DocsController < ActionController::Base
  include WeakSwaggerParameters::Controller

  add_to_doc_section('TestMeOut')

  swagger_root swagger: '2.0' do
    info version: '1.0', title: 'The test api', description: 'Test api description'
    key :host, 'localhost:1234'
    key :basePath, ''
    key :consumes, ['application/json']
    key :produces, ['application/json']
  end

  def index
    render_docs('TestMeOut')
  end
end
