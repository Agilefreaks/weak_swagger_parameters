# frozen_string_literal: true
require 'spec_helper'

RSpec.describe DocsController, type: :controller do
  describe 'index' do
    let(:params) do
      {
        subject: 'Foo',
        context: 'Bar',
        runs: 42,
        passed: false,
        boolean_required: true,
        string_required: 'baz',
        integer_required: 12,
        string_enum: 'a'
      }
    end

    subject { process :index, method: :get }

    before { request.env['CONTENT_TYPE'] = 'application/json' }

    its(:status) { is_expected.to eq 200 }
  end
end
