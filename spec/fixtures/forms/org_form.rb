# frozen_string_literal: true

require_relative 'person_form'

class OrgForm < Slayer::Form
  attribute :owner, ::PersonForm

  validates_associated :owner
end
