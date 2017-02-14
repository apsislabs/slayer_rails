class TransactionService < Slayer::Service
  def self.execute
    transaction do
      Person.create
    end

    return true
  rescue
    return false
  end
end
