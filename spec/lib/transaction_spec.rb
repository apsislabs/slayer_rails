# frozen_string_literal: true

require 'spec_helper'

describe 'Transactions' do
  it 'responds to transaction' do
    expect(Slayer::Command.new).to respond_to :transaction
  end

  it 'runs transaction block' do
    expect { TransactionCommand.call }.to change { Person.count }.by(1)
  end

  it 'rolls back transaction block' do
    allow(Person).to receive(:create).and_raise(:error)

    expect { TransactionCommand.call }.to change { Person.count }.by(0)
  end
end
