require 'test_helper'

class SlayerRails::TransactionTest < Minitest::Test
  def test_command_responds_to_transaction_block
    assert Slayer::Command.new.respond_to?(:transaction)
  end

  def test_service_responds_to_transaction_block
    assert Slayer::Service.new.respond_to?(:transaction)
  end

  def test_command_runs_transaction_block
    assert TransactionCommand.call(pass: true).success?
  end

  def test_command_rolls_back_transaction_block
    assert TransactionCommand.call(pass: false).success?
  end
end
