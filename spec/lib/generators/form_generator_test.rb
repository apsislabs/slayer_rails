# frozen_string_literal: true

require 'rails/generators/test_case'

module SlayerRails
  class FormGeneratorTest < Rails::Generators::TestCase
    tests Slayer::Generators::FormGenerator
    destination File.expand_path('../../dummy/tmp', File.dirname(__FILE__))

    def test_form_skeleton_is_created
      self.class.arguments %w[Test]
      run_generator
      assert_file 'app/forms/test_form.rb', /class TestForm < Slayer::Form/
    end

    def test_form_attributes_are_created
      self.class.arguments %w[FieldTest name:String age:Integer comment other]
      run_generator
      assert_file 'app/forms/field_test_form.rb' do |contents|
        assert_match(/class FieldTestForm < Slayer::Form/, contents)
        assert_match(/attribute :name, String/, contents)
        assert_match(/attribute :age, Integer/, contents)
        assert_match(/attribute :comment, String/, contents)
        assert_match(/attribute :other, String/, contents)
      end
    end
  end
end
