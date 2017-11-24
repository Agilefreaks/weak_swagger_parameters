# frozen_string_literal: true

class ModelChildResponse
  include WeakSwaggerParameters::Model

  add_to_doc_section('Test')

  attr_accessor :x

  model do
    string :x, 'The X'
  end
end
