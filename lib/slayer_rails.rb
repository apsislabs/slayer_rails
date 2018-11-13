require 'active_support'
require 'active_model'
require 'active_record'
require 'slayer'

require 'slayer_rails/version'
require 'slayer_rails/extensions/form'
require 'slayer_rails/extensions/transaction'
require 'slayer_rails/extensions/translation'

require 'generators/slayer_base'
require 'generators/command/command_generator'
require 'generators/service/service_generator'
require 'generators/form/form_generator'
require 'generators/scaffold/scaffold_generator'

module Slayer
  class Form
    include SlayerRails::Extensions::Form
    include SlayerRails::Extensions::Translation
  end

  class Command
    include SlayerRails::Extensions::Transaction
    include SlayerRails::Extensions::Translation
  end

  class Service
    include SlayerRails::Extensions::Transaction
    include SlayerRails::Extensions::Translation
  end
end
