ENV["RAILS_ENV"] ||= 'test'
require File.expand_path('../../spec/dummy/config/environment', __FILE__)

require 'bundler/setup'
require 'rspec/rails'
require 'rspec/autorun'
require 'woople-theme'

RSpec.configure do |config|
  #config.include ActionView::TestCase::Behavior, example_group: {file_path: %r{spec/presenters}}
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
end
