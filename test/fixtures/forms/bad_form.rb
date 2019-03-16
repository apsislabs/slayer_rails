class BadForm < Slayer::Form
  attribute :name_and_age, String

  def get_name
    name_and_age.split(' ').last
  end

  def get_age
    name_and_age.split(' ').first.to_i
  end
end
