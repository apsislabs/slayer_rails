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

  private

    def make_params(hash)
      ActionController::Parameters.new(hash)
    end
end
