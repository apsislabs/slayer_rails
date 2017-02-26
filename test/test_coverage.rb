# Setup Test Coverage Reporting
# --------------------------------------------------------
require 'simplecov'
require 'coveralls'
require 'minitest/autorun'
require 'minitest/reporters'

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]

SimpleCov.start do
  add_filter '/test/'
  minimum_coverage(95)
end

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
