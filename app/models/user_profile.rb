# frozen_string_literal: true

# app/models/user_profile.rb
class UserProfile < ApplicationRecord
  # Associations
  belongs_to :user

  # Validations
  validates_presence_of :first_name, :phone

  def full_name
    first_name + last_name
  end
end
