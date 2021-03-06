# frozen_string_literal: true

require 'spec_helper'

RSpec.describe PostTestsController, type: :controller do
  describe 'create' do
    let(:params) do
      {
        subject: 'Foo',
        context: 'Bar',
        runs: 42,
        passed: false,
        boolean_required: true,
        string_required: 'baz',
        integer_required: 12,
        float_required: 4.2,
        string_enum: 'a',
        position: 1
      }
    end

    subject { process :create, method: :post, params: params }

    before { request.env['CONTENT_TYPE'] = 'application/json' }

    context 'body parameter is enum' do
      let(:param_name) { :string_enum }

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
      let(:param_name) { :string_required }

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

          expect(controller.permitted_params[param_name]).to eq(0)
        end
      end

      context 'when value is 1' do
        before :each do
          params[param_name] = 1
        end

        its(:status) { is_expected.to eq 201 }

        it 'has permitted param' do
          subject

          expect(controller.permitted_params[param_name]).to eq(1)
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

        its(:status) { is_expected.to eq 400 }
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

    context 'body param is specified as number with' do
      let(:param_name) { :position }

      context 'value is between min and max value' do
        before :each do
          params[param_name] = 42
        end

        its(:status) { is_expected.to eq 201 }
      end

      context 'value is less than minimum value' do
        before :each do
          params[param_name] = 0
        end

        its(:status) { is_expected.to eq 400 }
      end

      context 'value is greater than maximum value' do
        before :each do
          params[param_name] = 1000
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

    context 'body parameter is specified as float' do
      let(:param_name) { :float_required }

      context 'when value is integr' do
        before :each do
          params[param_name] = 42
        end

        its(:status) { is_expected.to eq 201 }

        it 'has permitted param' do
          subject

          expect(controller.permitted_params[param_name]).to eq(42)
        end
      end

      context 'when value is stringified integer' do
        before :each do
          params[param_name] = '42'
        end

        its(:status) { is_expected.to eq 201 }

        it 'has permitted param' do
          subject

          expect(controller.permitted_params[param_name]).to eq(42)
        end
      end

      context 'when value is string field float' do
        before :each do
          params[param_name] = '4.2'
        end

        its(:status) { is_expected.to eq 201 }

        it 'has permitted param' do
          subject

          expect(controller.permitted_params[param_name]).to eq(4.2)
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

        its(:status) { is_expected.to eq(201) }

        it 'has permitted param' do
          subject

          expect(controller.permitted_params[param_name]).to eq(4.2)
        end
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

    context 'body parameter is hash' do
      let(:param_name) { :my_hash }

      context 'when value is string' do
        before :each do
          params[param_name] = 'test'
        end

        its(:status) { is_expected.to eq 400 }
      end

      context 'when value is hash' do
        before :each do
          params[param_name] = {}
        end

        its(:status) { is_expected.to eq 201 }
      end
    end

    context 'body parameter is model' do
      let(:param_name) { :nested_model }

      context 'when value is string' do
        before :each do
          params[param_name] = 'test'
        end

        its(:status) { is_expected.to eq 400 }
      end

      context 'when value is hash' do
        before :each do
          params[param_name] = {}
        end

        its(:status) { is_expected.to eq 201 }
      end
    end

    context 'body parameter is number with just min constraint' do
      let(:param_name) { :max_missing }

      context 'value is large' do
        before :each do
          params[param_name] = 5_000_000_000
        end

        its(:status) { is_expected.to eq 201 }
      end

      context 'value is below minimum' do
        before :each do
          params[param_name] = 0
        end

        its(:status) { is_expected.to eq 400 }
      end
    end

    context 'body parameter is number with just max constraint' do
      let(:param_name) { :min_missing }

      context 'value is small' do
        before :each do
          params[param_name] = - 5_000_000_000
        end

        its(:status) { is_expected.to eq 201 }
      end

      context 'value is above maximum' do
        before :each do
          params[param_name] = 101
        end

        its(:status) { is_expected.to eq 400 }
      end
    end

    context 'path parameter is specified as number' do
      let(:param_name) { :count }

      context 'when value is not number' do
        before :each do
          params[param_name] = 'asd'
        end

        its(:status) { is_expected.to eq 400 }
      end

      context 'when value is string number' do
        before :each do
          params[param_name] = '42'
        end

        its(:status) { is_expected.to eq 201 }
      end

      context 'when value is greater than max' do
        before :each do
          params[param_name] = '20000'
        end

        its(:status) { is_expected.to eq 400 }
      end

      context 'when value is lower than min' do
        before :each do
          params[param_name] = '0'
        end

        its(:status) { is_expected.to eq 400 }
      end
    end

    context 'query parameter has enum' do
      let(:param_name) { :type }

      context 'value is in enum' do
        before :each do
          params[param_name] = 'a'
        end

        its(:status) { is_expected.to eq 201 }
      end

      context 'value is not in enum' do
        before :each do
          params[param_name] = 'z'
        end

        its(:status) { is_expected.to eq 400 }
      end
    end

    context 'path parameter has enum' do
      let(:param_name) { :path_enum }

      context 'value is in enum' do
        before :each do
          params[param_name] = 'a'
        end

        its(:status) { is_expected.to eq 201 }
      end

      context 'value is not in enum' do
        before :each do
          params[param_name] = 'z'
        end

        its(:status) { is_expected.to eq 400 }
      end
    end
  end
end
