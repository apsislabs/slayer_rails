class TransactionCommand < Slayer::Command
  def call(pass: false)
    transaction do
      raise ActiveRecord::Rollback unless pass
      pass! result: nil
    end

    fail! result: nil
  end
end
