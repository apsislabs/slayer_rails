require 'rails/generators/test_case'

class SlayerRails::CommandGeneratorTest < ::Rails::Generators::TestCase
  tests Slayer::Generators::CommandGenerator
  destination File.expand_path("../sample/tmp", File.dirname(__FILE__))

  def setup
    prepare_destination
    run_generator %w(test_command)
  end

  test "generates expected file" do
    assert_file "commands/test_command.rb"
  end
end
