require 'test_helper'

class SlayerRails::TranslationTest < ActiveSupport::TestCase
  def test_command_responds_to_translate
    assert Slayer::Command.new.respond_to?(:translate)
    assert Slayer::Command.new.respond_to?(:t)
  end

  def test_service_responds_to_localize
    assert Slayer::Service.new.respond_to?(:localize)
    assert Slayer::Service.new.respond_to?(:l)
  end

  def test_form_responds_to_localize
    assert Slayer::Form.new.respond_to?(:localize)
    assert Slayer::Form.new.respond_to?(:l)
  end

  def test_translate
    ["commands.test.demo", "services.test.demo", "forms.test.demo"].each do |key|
      expected = key.split('.').first.singluarize.titleize
      assert_equal expected, TestCommand.new.t key
      assert_equal expected, TestService.new.t key
      assert_equal expected, TestForm.new.t key
    end
  end

  def test_translate_shortcut
    [TestCommand, TestService, TestForm].each do |klass|
      expected = klass.name.underscore.split("_").last.titleize
      assert_equal expected, klass.new.t ".demo"
    end
  end

  def test_localize
    [TestCommand, TestService, TestForm].each do |klass|
      assert_equal "3PM", klass.new.l three_o_clock, format: "%l%p"
    end
  end

  private

  def three_o_clock
    Time.parse("3:00pm")
  end
end
