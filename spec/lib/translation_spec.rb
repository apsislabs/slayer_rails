# frozen_string_literal: true

require 'spec_helper'

# rubocop:disable Metrics/BlockLength
describe 'Translation' do
  it 'responds to translate' do
    expect(Slayer::Command.new).to respond_to :translate
    expect(Slayer::Command.new).to respond_to :t
  end

  it 'responds to localize' do
    expect(Slayer::Command.new).to respond_to :localize
    expect(Slayer::Command.new).to respond_to :l
  end

  it 'transates' do
    ['commands.transaction.demo', 'services.transaction.demo', 'forms.person.demo'].each do |key|
      expected = key.split('.').first.singularize.titleize
      expect(TransactionCommand.new.translate(key)).to eq expected
      expect(PersonForm.new.translate(key)).to eq expected
    end
  end

  it 'translates with shortcut' do
    [TransactionCommand, PersonForm].each do |klass|
      expected = klass.name.underscore.split('_').last.titleize
      expect(klass.new.t('.demo')).to eq expected
    end
  end

  it 'transates shortcut for module' do
    result = GoodCustomer::AwesomeProduct::RunFooBarCommand.new.translate('.demo')
    expect(result).to eq 'It Lives'
  end

  it 'localizes' do
    [TransactionCommand, PersonForm].each do |klass|
      expect(klass.new.l(three_o_clock, format: '%I%p')).to eq '03PM'
    end
  end

  private

  def three_o_clock
    Time.parse('3:00pm')
  end
end
# rubocop:enable Metrics/BlockLength
