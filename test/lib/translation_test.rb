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
    ["commands.transaction.demo", "services.transaction.demo", "forms.person.demo"].each do |key|
      expected = key.split('.').first.singularize.titleize
      assert_equal expected, TransactionCommand.new.translate(key)
      assert_equal expected, TransactionService.new.translate(key)
      assert_equal expected, PersonForm.new.translate(key)
    end
  end

  def test_translate_shortcut
    [TransactionCommand, TransactionService, PersonForm].each do |klass|
      expected = klass.name.underscore.split("_").last.titleize
      assert_equal expected, klass.new.t(".demo")
    end
  end

  def test_translate_shortcut_for_module
    result = GoodCustomer::AwesomeProduct::RunFooBarCommand.new.translate(".demo")
    assert_equal "It Lives", result
  end

  def test_localize
    [TransactionCommand, TransactionService, PersonForm].each do |klass|
      assert_equal "03PM", klass.new.l(three_o_clock, format: "%I%p")
    end
  end

  private

  def three_o_clock
    Time.parse("3:00pm")
  end
end
