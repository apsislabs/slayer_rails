require "rubygems"
require "bundler/setup"

require "bundler/gem_tasks"
require "rake/testtask"

require "./tasks/db"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList['test/lib/**/*_test.rb']
end

task :default => :test
