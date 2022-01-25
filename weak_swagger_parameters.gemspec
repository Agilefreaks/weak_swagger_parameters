# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'weak_swagger_parameters/version'

Gem::Specification.new do |spec|
  spec.name          = 'weak_swagger_parameters'
  spec.version       = ::WeakSwaggerParameters::VERSION
  spec.authors       = ['AgileFreaks']
  spec.email         = ['office@agilefreaks.com']

  spec.summary       = 'Generate docs and Validate request parameters'
  spec.description   = 'Basic integration between swagger-blocks and weak_parameters'
  spec.homepage      = 'https://github.com/Agilefreaks/weak_swagger_parameters'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rails', '>= 4'
  spec.add_dependency 'swagger-blocks', '~> 3.0'
  spec.add_dependency 'weak_parameters', '~> 0.5'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'json-schema', '~> 2.6'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-its', '~> 1.2'
  spec.add_development_dependency 'rspec-rails', '~> 3.4'
  spec.add_development_dependency 'rubocop', '~> 0.51.0'
  spec.add_development_dependency 'sqlite3', '~> 1.3'
end
