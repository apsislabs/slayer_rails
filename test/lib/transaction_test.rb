require 'test_helper'

class SlayerRails::TransactionTest < ActiveSupport::TestCase
  def test_command_responds_to_transaction_block
    assert Slayer::Command.new.respond_to?(:transaction)
  end

  def test_service_responds_to_transaction_block
    assert Slayer::Service.new.respond_to?(:transaction)
  end

  def test_command_runs_transaction_block
     assert_difference ->{Person.count}, 1 do
       result = TransactionCommand.call
       assert result.success?
     end
  end

  def test_command_rolls_back_transaction_block
    Person.expects(:create).throws(:error)

    assert_no_difference -> { Person.count } do
      result = TransactionCommand.call
      assert result.failure?
    end
  end

  def test_service_runs_transaction_block
     assert_difference -> { Person.count }, 1 do
       assert TransactionService.execute
     end
  end

  def test_service_rolls_back_transaction_block
    Person.expects(:create).throws(:error)

    assert_no_difference -> { Person.count } do
      refute TransactionService.execute
    end
  end
end
