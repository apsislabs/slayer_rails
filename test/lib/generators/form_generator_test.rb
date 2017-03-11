require 'rails/generators/test_case'

class SlayerRails::FormGeneratorTest < Rails::Generators::TestCase
  tests Slayer::Generators::FormGenerator
  destination File.expand_path("../../sample/tmp", File.dirname(__FILE__))

  arguments %w(Test)
  def test_form_skeleton_is_created
    run_generator
    assert_file "app/forms/test_form.rb", /class TestForm < Slayer::Form/
  end

  arguments %w(FieldTest name:String age:Integer comment other)
  def test_form_attributes_are_created
    run_generator
    assert_file "app/forms/field_test_form.rb" do |contents|
      assert_match(/class FieldTestForm < Slayer::Form/, contents)
      assert_match(/attribute :name, String/, contents)
      assert_match(/attribute :age, Integer/, contents)
      assert_match(/attribute :comment, String/, contents)
      assert_match(/attribute :other, String/, contents)
    end
  end
end
