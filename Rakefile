# frozen_string_literal: true

require "rubygems"
require "bundler/setup"
require "bundler/gem_tasks"

require "rake"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :standard do
  sh "bundle exec standardrb"
end

task :appraisal do
  sh "bundle exec appraisal rspec"
end

namespace :dummy do
  require_relative "spec/dummy/application"
  Dummy::Application.load_tasks
end

task default: [:standard, :appraisal]
