# frozen_string_literal: true

# app/models/user_profile.rb
class UserProfile < ApplicationRecord
  belongs_to :user
  validates_presence_of :first_name, :phone
end
