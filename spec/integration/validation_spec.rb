# frozen_string_literal: true
require 'spec_helper'

RSpec.describe 'Controller Action Validation', type: :controller do
  controller(ActionController::Base) do
    include WeakSwaggerParameters::Controller

    add_to_doc_section('Test')

    api :create, '/tests/{short_name}/{count}', 'Create test' do
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
          string :required_field, 'The required field', required: true
          string :enum_field, 'The enum field', enum: %w(a b)
        end
      end

      response 201, 'Created the test'
      response 400, 'Bad Request'
    end
    def create
      head 201
    end
  end

  describe 'create' do
    let(:params) do
      {
          short_name: 'foo-bar',
          count: '42',
          subject: 'Foo',
          context: 'Bar',
          runs: 42,
          passed: false,
          required_field: 'baz',
          enum_field: 'a',
          token: 'token'
      }
    end

    subject { post :create, params }

    context 'body parameter is enum' do
      let(:param_name) { :enum_field }

      context 'when missing' do
        before :each do
          params.delete(param_name)
        end

        its(:status) { is_expected.to eq(201) }
      end

      context 'when has valid value' do
        before :each do
          params[param_name] = 'a'
        end

        its(:status) { is_expected.to eq(201) }
      end

      context 'when has invalid value' do
        before :each do
          params[param_name] = 'x'
        end

        its(:status) { is_expected.to eq(400) }
      end
    end

    context 'body parameter is required' do
      let(:param_name) { :required_field }

      context 'when missing' do
        before :each do
          params.delete(param_name)
        end

        its(:status) { is_expected.to eq(400) }
      end

      context 'when present' do
        before :each do
          params[param_name] = '42'
        end

        its(:status) { is_expected.to eq(201) }
      end
    end

    context 'body parameter is specified as boolean' do
      let(:param_name) { :passed }

      context 'when value is true' do
        before :each do
          params[param_name] = true
        end

        its(:status) { is_expected.to eq 201 }

        it 'has permitted param' do
          subject

          expect(controller.permitted_params[param_name]).to eq(true)
        end
      end

      context 'when value is false' do
        before :each do
          params[param_name] = false
        end

        its(:status) { is_expected.to eq 201 }

        it 'has permitted param' do
          subject

          expect(controller.permitted_params[param_name]).to eq(false)
        end
      end

      context 'when value is 0' do
        before :each do
          params[param_name] = 0
        end

        its(:status) { is_expected.to eq 201 }

        it 'has permitted param' do
          subject

          expect(controller.permitted_params[param_name]).to eq('0')
        end
      end

      context 'when value is 1' do
        before :each do
          params[param_name] = 1
        end

        its(:status) { is_expected.to eq 201 }

        it 'has permitted param' do
          subject

          expect(controller.permitted_params[param_name]).to eq('1')
        end
      end

      context 'when value is 2' do
        before :each do
          params[param_name] = 2
        end

        its(:status) { is_expected.to eq 400 }
      end

      context 'when value is string' do
        before :each do
          params[param_name] = '42'
        end

        its(:status) { is_expected.to eq 400 }
      end
    end

    context 'body parameter is specified as string' do
      let(:param_name) { :subject }

      context 'when value is integer' do
        before :each do
          params[param_name] = 42
        end

        its(:status) { is_expected.to eq 201 }

        it 'has permitted param' do
          subject

          expect(controller.permitted_params[param_name]).to eq('42')
        end
      end

      context 'when value is boolean' do
        before :each do
          params[param_name] = true
        end

        its(:status) { is_expected.to eq 400 }
      end

      context 'when value is object' do
        before :each do
          params[param_name] = {}
        end

        its(:status) { is_expected.to eq 400 }
      end

      context 'when value is array' do
        before :each do
          params[param_name] = []
        end

        its(:status) { is_expected.to eq 400 }
      end
    end

    context 'body parameter is specified as number' do
      let(:param_name) { :runs }

      context 'when value is number' do
        before :each do
          params[param_name] = 42
        end

        its(:status) { is_expected.to eq 201 }

        it 'has permitted param' do
          subject

          expect(controller.permitted_params[param_name]).to eq(42)
        end
      end

      context 'when value is stringified number' do
        before :each do
          params[param_name] = '42'
        end

        its(:status) { is_expected.to eq 201 }

        it 'has permitted param' do
          subject

          expect(controller.permitted_params[param_name]).to eq(42)
        end
      end

      context 'when value is invalid number string' do
        before :each do
          params[param_name] = 'abc'
        end

        its(:status) { is_expected.to eq(400) }
      end

      context 'when value is float' do
        before :each do
          params[param_name] = 4.2
        end

        its(:status) { is_expected.to eq(400) }
      end

      context 'when value is object' do
        before :each do
          params[param_name] = {}
        end

        its(:status) { is_expected.to eq(400) }
      end

      context 'when value is array' do
        before :each do
          params[param_name] = []
        end

        its(:status) { is_expected.to eq(400) }
      end

      context 'when value is boolean' do
        before :each do
          params[param_name] = true
        end

        its(:status) { is_expected.to eq(400) }
      end
    end
  end
end
