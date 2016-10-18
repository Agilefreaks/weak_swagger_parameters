# frozen_string_literal: true
class ModelResponse
  include WeakSwaggerParameters::Model

  add_to_doc_section('Test')

  attr_accessor :foo, :bar, :baz

  model do
    string :foo, 'The foo of the model'
    integer :bar, 'The bar of the model'
    boolean :baz, 'The baz of the model'
  end
end
