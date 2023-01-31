# frozen_string_literal: true

require 'rails/generators/test_case'

module SlayerRails
  class CommandGeneratorTest < Rails::Generators::TestCase
    tests Slayer::Generators::CommandGenerator
    destination File.expand_path('../../dummy/tmp', File.dirname(__FILE__))

    arguments %w[Test]

    def test_command_skeleton_is_created
      run_generator
      assert_file 'app/commands/test_command.rb', /class TestCommand < Slayer::Command/
    end
  end
end
