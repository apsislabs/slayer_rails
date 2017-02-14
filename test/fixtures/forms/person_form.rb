class PersonForm < Slayer::Form
  attribute :name, String
  attribute :age, Integer

  attribute :friends, Array

  validates_presence_of :name, :age
end
