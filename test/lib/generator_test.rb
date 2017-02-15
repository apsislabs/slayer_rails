require 'rails/generators/test_case'

class SlayerRails::CommandGeneratorTest < Rails::Generators::TestCase
  tests Slayer::Generators::CommandGenerator
  destination File.expand_path("../sample/tmp", File.dirname(__FILE__))

  arguments %w(Test)

  def test_command_skeleton_is_created
    run_generator
    assert_file "app/commands/test_command.rb", /class TestCommand < Slayer::Command/
  end
end
