require 'test_helper'
require 'json'

class SlayerRails::FormTest < Minitest::Test
  def test_is_valid_with_good_data
    form = PersonForm.new({ name: 'Luke Skywalker', age: 20 })

    assert_equal 'Luke Skywalker', form.name
    assert_equal 20, form.age

    assert form.valid?
    refute form.invalid?
  end

  def test_is_invalid_with_bad_data
    form = PersonForm.new({ name: 'Luke Skywalker', age: nil })

    assert_equal 'Luke Skywalker', form.name
    assert_nil form.age

    assert form.invalid?
    refute form.valid?
  end

  def test_raises_exception_if_validates_invalid
    assert_raises Slayer::FormValidationError do
      PersonForm.new.validate!
    end
  end

  def test_instantiates_from_json
    json = { name: 'Luke Skywalker', age: 20 }.to_json
    form = PersonForm.from_json(json)

    assert_equal 20, form.age
    assert form.valid?
  end

  def test_instantiates_from_params
    params = make_params({ name: 'Leia Organa', age: 20 })
    form   = PersonForm.from_params(params)

    assert_equal 20, form.age
    assert form.valid?
  end

  def test_instantiates_from_params_with_root_key
    params = make_params({ person: { name: 'Leia Organa', age: 20 } })
    form   = PersonForm.from_params(params, root_key: :person)

    assert_equal 20, form.age
    assert form.valid?
  end

  def test_insantiates_from_params_with_nil_root_key
    params = make_params({ name: 'Leia Organa', age: 20 })
    form   = PersonForm.from_params(params, root_key: nil)

    assert_equal 20, form.age
    assert form.valid?
  end

  def test_instantiates_from_params_with_complex_data
    friends = ['Luke', 'Han', 'Chewie']
    params  = make_params({ friends: friends })
    form    = PersonForm.from_params(params)

    assert_equal friends, form.friends
  end

  def test_instantiates_from_params_with_additional
    params = make_params({ name: 'Leia Organa'})
    form = PersonForm.from_params(params)

    assert_nil form.age
    assert form.invalid?

    form = PersonForm.from_params(params, additional_params: { age: 20 })

    assert_equal 20, form.age
    assert form.valid?
  end

  def test_instantiates_from_model
    person = Person.create({ name: 'Han Solo', age: 30 })
    form = PersonForm.from_model(person)

    assert_equal 'Han Solo', form.name
    assert_equal 30, form.age

    assert form.valid?
    refute form.invalid?
  end

  def test_instantiates_invalid_from_model
    person = Person.create({ name: 'Han Solo' })
    form = PersonForm.from_model(person)

    refute form.valid?
    assert form.invalid?
  end

  def test_simple_to_model
    person_form = PersonForm.new({ name: 'Luke Skywalker', age: 20 })
    person = person_form.to_model(Person)

    assert person.is_a? Person
    assert_equal person.name, person_form.name
    assert_equal person.age, person_form.age
  end

  def test_custom_to_model_methods
    bad_form = BadForm.new({ name_and_age: 'Luke 20' })
    person = bad_form.to_model(Person, {
      name: :get_name,
      age: :get_age,
    })

    assert person.is_a? Person
    assert_equal person.name, bad_form.get_name
    assert_equal person.age, bad_form.get_age
  end

  def test_custom_to_model_mapping
    person_form = PersonForm.new({ name: 'Luke Skywalker', age: 20 })
    person = person_form.to_model(Person, {
      name: :age,
    })

    assert person.is_a? Person
    assert_equal person.name, person_form.age.to_s
  end

  def test_validates_associated
    org_form = OrgForm.new({
      owner: PersonForm.new({
        name: "Yoda"
      })
    })
    refute org_form.valid?
    assert_equal org_form.errors[:owner].length, 1
    assert_equal org_form.errors[:owner][0], "age can't be blank"
  end

  def test_validates_associated
    org_form = OrgForm.new({
      owner: PersonForm.new({
        name: "Yoda",
        age: 900
      })
    })
    assert org_form.valid?
    assert_equal org_form.errors[:owner].length, 0
  end

  private

    def make_params(hash)
      ActionController::Parameters.new(hash)
    end
end
