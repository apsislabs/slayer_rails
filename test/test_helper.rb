$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'slayer_rails'
require 'byebug'
require 'minitest/autorun'
require 'action_controller'

Dir['test/assertions/**/*.rb'].each { |f| require File.expand_path(f) }
Dir['test/fixtures/**/*.rb'].each { |f| require File.expand_path(f) }

system("bundle exec rake db:migrate")

db_config = YAML.load(File.open("test/config/database.yml"))
ActiveRecord::Base.establish_connection(db_config)
