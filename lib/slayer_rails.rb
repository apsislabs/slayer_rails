require 'active_support'
require 'active_model'
require 'active_record'
require 'slayer'

require 'slayer_rails/version'
require 'slayer_rails/extensions/form'
require 'slayer_rails/extensions/transaction'

module Slayer
  class Form
    include SlayerRails::Extensions::Form
  end

  class Command
    include SlayerRails::Extensions::Transaction
  end

  class Service
    include SlayerRails::Extensions::Transaction
  end
end
