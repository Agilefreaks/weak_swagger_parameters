# frozen_string_literal: true

Dummy::Application.routes.draw do
  resources :delete_tests
  resources :get_tests
  resources :patch_tests
  resources :post_tests
  resources :put_tests
  resources :docs
end
