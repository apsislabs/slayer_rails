# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
require 'bundler/gem_tasks'

require 'rake'
require 'rspec/core/rake_task'

namespace :dummy do
  require_relative 'spec/dummy/application'
  Dummy::Application.load_tasks
end

task default: :spec
