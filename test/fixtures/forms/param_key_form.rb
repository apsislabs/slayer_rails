class ParamKeyForm < Slayer::Form
  set_param_key :foo

  attribute :bar, String

  validates_presence_of :bar
end
