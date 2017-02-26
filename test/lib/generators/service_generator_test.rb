require 'rails/generators/test_case'

class SlayerRails::ServiceGeneratorTest < Rails::Generators::TestCase
  tests Slayer::Generators::ServiceGenerator
  destination File.expand_path("../sample/tmp", File.dirname(__FILE__))

  arguments %w(Test)

  def test_service_skeleton_is_created
    run_generator
    assert_file "app/services/test_service.rb", /class TestService < Slayer::Service/
  end
end
