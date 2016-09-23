# frozen_string_literal: true
# Be sure to restart your server when you modify this file.
#
# This file contains settings for ActionController::ParamsWrapper which
# is enabled by default.

# Disable root element in JSON by default.
ActiveSupport.on_load(:active_record) do
  self.include_root_in_json = false
end
