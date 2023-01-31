# frozen_string_literal: true

require 'spec_helper'
require 'json'

# rubocop:disable Metrics/BlockLength
describe Slayer::Form do
  it 'is valid with good data' do
    form = PersonForm.new({ name: 'Luke Skywalker', age: 20 })

    expect(form.name).to eq 'Luke Skywalker'
    expect(form.age).to eq 20

    expect(form.valid?).to be true
    expect(form.invalid?).to be false
  end

  it 'is invalid with bad data' do
    form = PersonForm.new({ name: 'Luke Skywalker', age: nil })

    expect(form.name).to eq 'Luke Skywalker'
    expect(form.age).to eq nil

    expect(form.valid?).to be false
    expect(form.invalid?).to be true
  end

  it 'raises exception if invalid' do
    expect { PersonForm.new.validate! }.to raise_error(Slayer::FormValidationError)
  end

  it 'instantiates from JSON' do
    json = { name: 'Luke Skywalker', age: 20 }.to_json
    form = PersonForm.from_json(json)

    expect(form.name).to eq 'Luke Skywalker'
    expect(form.age).to eq 20
    expect(form.valid?).to be true
  end

  it 'instantiates from params' do
    params = make_params({ name: 'Leia Organa', age: 20 })
    form   = PersonForm.from_params(params)

    expect(form.name).to eq 'Leia Organa'
    expect(form.age).to eq 20
    expect(form.valid?).to be true
  end

  it 'instantiates from params with root key' do
    params = make_params({ person: { name: 'Leia Organa', age: 20 } })
    form   = PersonForm.from_params(params, root_key: :person)

    expect(form.name).to eq 'Leia Organa'
    expect(form.age).to eq 20
    expect(form.valid?).to be true
  end

  it 'instantiates from params with nil root key' do
    params = make_params({ name: 'Leia Organa', age: 20 })
    form   = PersonForm.from_params(params, root_key: nil)

    expect(form.name).to eq 'Leia Organa'
    expect(form.age).to eq 20
    expect(form.valid?).to be true
  end

  it 'instantiates from params with complex data' do
    friends = %w[Luke Han Chewie]
    params  = make_params({ friends: friends })
    form    = PersonForm.from_params(params)

    expect(form.friends).to eq friends
  end

  it 'instantiates from params with additional data' do
    params = make_params({ name: 'Leia Organa' })
    form = PersonForm.from_params(params)

    assert_nil form.age
    assert form.invalid?

    form = PersonForm.from_params(params, additional_params: { age: 20 })

    expect(form.name).to eq 'Leia Organa'
    expect(form.age).to eq 20
    expect(form.valid?).to be true
  end

  it 'instantiates from model' do
    person = Person.create({ name: 'Han Solo', age: 30 })
    form = PersonForm.from_model(person)

    expect(form.name).to eq 'Han Solo'
    expect(form.age).to eq 30
    expect(form.valid?).to be true
  end

  it 'instantiates from model' do
    person = Person.create({ name: 'Han Solo', age: 30 })
    form = PersonForm.from_model(person)

    expect(form.name).to eq 'Han Solo'
    expect(form.age).to eq 30
    expect(form.valid?).to be true
  end

  it 'instantiates invalid from model' do
    person = Person.create({ name: 'Han Solo' })
    form = PersonForm.from_model(person)

    expect(form.name).to eq 'Han Solo'
    expect(form.valid?).to be false
  end

  describe '#as_model' do
    it 'converts to model' do
      person_form = PersonForm.new({ name: 'Luke Skywalker', age: 20 })
      person = person_form.as_model(Person)

      expect(person).to be_a Person
      expect(person.name).to eq person_form.name
      expect(person.age).to eq person_form.age
    end

    it 'converts to model with custom methods' do
      bad_form = BadForm.new({ name_and_age: 'Luke 20' })
      person = bad_form.as_model(Person, {
                                   name: :get_name,
                                   age: :get_age
                                 })

      expect(person).to be_a Person
      expect(person.name).to eq bad_form.get_name
      expect(person.age).to eq bad_form.get_age
    end

    it 'converts to model with custom mapping' do
      person_form = PersonForm.new({ name: 'Luke Skywalker', age: 20 })
      person = person_form.as_model(Person, {
                                      name: :age
                                    })

      assert person.is_a? Person
      assert_equal person.name, person_form.age.to_s
    end
  end

  describe 'associations' do
    it 'validates associations' do
      org_form = OrgForm.new({
                               owner: PersonForm.new({
                                                       name: 'Yoda'
                                                     })
                             })

      expect(org_form.valid?).to be false
      expect(org_form.errors[:owner]).to contain_exactly "age can't be blank"
    end
  end

  private

  def make_params(hash)
    ActionController::Parameters.new(hash)
  end
end
# rubocop:enable Metrics/BlockLength
