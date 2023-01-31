# frozen_string_literal: true

class TransactionCommand < Slayer::Command
  def call
    transaction do
      Person.create
    end

    ok
  rescue StandardError
    err
  end
end
