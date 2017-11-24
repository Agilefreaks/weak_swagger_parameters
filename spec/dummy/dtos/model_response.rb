# frozen_string_literal: true

class ModelResponse
  include WeakSwaggerParameters::Model

  add_to_doc_section('Test')

  attr_accessor :foo, :bar, :baz, :bav

  model do
    hash :container, 'The container' do
      string :foo, 'The foo of the model'
      integer :bar, 'The bar of the model'
      float :bav, 'The bav of the model'
      boolean :baz, 'The baz of the model'
      model :child, 'The Child', ::ModelChildResponse
      collection :children, 'The Children', ::ModelChildResponse
    end
  end
end
