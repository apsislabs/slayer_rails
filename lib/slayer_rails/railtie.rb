require 'slayer'
require 'rails'

module Slayer
  class << self
    attr_accessor :test_framework
    attr_accessor :factory_bot
  end

  class Railtie < Rails::Railtie
    initializer 'slayer.set_options' do
      Slayer.test_framework = config.generators.options[:rails][:test_framework]
      Slayer.factory_bot    = config.generators.options[:rails][:factory_bot]
    end
  end
end