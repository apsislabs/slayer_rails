class TransactionCommand < Slayer::Command
  def call
    transaction do
      Person.create
    end

    pass! result: nil
  rescue
    fail! result: nil
  end
end
