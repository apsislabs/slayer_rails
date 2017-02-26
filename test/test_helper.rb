$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

# Setup Test Coverage Reporting
# --------------------------------------------------------
require 'test_coverage'

# Dependencies
require 'slayer_rails'
require 'byebug'
require 'mocha/mini_test'
require 'combustion'

# Fixtures
Dir['test/fixtures/**/*.rb'].each { |f| require File.expand_path(f) }

# Set up fake Rails App
Combustion.path = 'test/sample'
Combustion.initialize! :all
