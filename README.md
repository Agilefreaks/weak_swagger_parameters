[![Build Status](https://travis-ci.org/Agilefreaks/weak_swagger_parameters.svg?branch=master)](https://travis-ci.org/Agilefreaks/weak_swagger_parameters)
[![Code Climate](https://codeclimate.com/github/Agilefreaks/weak_swagger_parameters/badges/gpa.svg)](https://codeclimate.com/github/Agilefreaks/weak_swagger_parameters)
[![Test Coverage](https://codeclimate.com/github/Agilefreaks/weak_swagger_parameters/badges/coverage.svg)](https://codeclimate.com/github/Agilefreaks/weak_swagger_parameters/coverage)

# WeakSwaggerParameters

This is an integration gem between `weak_parameters` and `swagger-blocks` to allow creating interactive swagger documentation and input parameter validation without duplicating the definitions using both DSLs.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'weak_swagger_parameters'
```

And then execute:

    $ bundle install

## Usage

(1) Add route to a docs controller to serve Swagger v2.0 json
````ruby
# routes.rb

namespace :v1 do
  resources :docs, only: [:index]
end
````

(2) Create a controller for serving the Swagger v2.0 json
````ruby
module V1
  class DocsController < ActionController::Base
    include WeakSwaggerParameters::Controller
 
    add_to_doc_section('V1')
 
    swagger_root swagger: '2.0' do
      info version: '1.0', title: 'The best api', description: 'Api that does everything'
      key :host, 'example.com'
      key :consumes, ['application/json']
      key :produces, ['application/json']
    end
    def index
      render_docs('V1')
    end
  end
end
````

(3) Add metadata to existing controllers for them to show up in the documentation

````ruby
  class ItemsController < ActionController::Base
    include WeakSwaggerParameters::Controller

    add_to_doc_section('V1')

    api :create, '/tests', 'Create test' do
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
          boolean :boolean_required, 'Boolean required', required: true
          string :string_required, 'String required', required: true
          integer :integer_required, 'Integer required', required: true
          string :string_enum, 'String enum', enum: %w(a b c)
          string :string_default, 'String default', default: 'origin'
        end
      end
      response 201, 'Created the test'
      response 400, 'Bad Request'
    end
    def create
      # ...
    end
  end
````

For complete examples, see the specs.

## Development

Install dependencies
  
```
  bundle install
```

Run Specs
  
```
  bundle exec rake rspec
```

Run Rubocop
  
```
  bundle exec rake rubocop
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/AgileFreaks/weak_swagger_parameters. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

