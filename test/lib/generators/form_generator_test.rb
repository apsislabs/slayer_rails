require 'rails/generators/test_case'

class SlayerRails::FormGeneratorTest < Rails::Generators::TestCase
  tests Slayer::Generators::FormGenerator
  destination File.expand_path("../../sample/tmp", File.dirname(__FILE__))

  arguments %w(Test)

  def test_form_skeleton_is_created
    run_generator
    assert_file "app/forms/test_form.rb", /class TestForm < Slayer::Form/
  end
end
