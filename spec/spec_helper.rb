# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'

require 'rails/all'
require 'dummy/application'

require 'byebug'
require 'rspec/rails'
require 'slayer_rails'

Dummy::Application.initialize!

# Fixtures
Dir['spec/fixtures/**/*.rb'].each { |f| require File.expand_path(f) }

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.order = :random
  config.use_transactional_fixtures = true

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
  end
end
