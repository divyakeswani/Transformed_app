# frozen_string_literal: true

# app/models/user_profile.rb
class UserRole < ApplicationRecord
  belongs_to :user
  belongs_to :organization
  belongs_to :role
end