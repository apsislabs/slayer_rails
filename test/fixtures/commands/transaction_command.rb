class TransactionCommand < Slayer::Command
  def call
    transaction do
      Person.create
    end

    pass!
  rescue
    fail!
  end
end
