# frozen_string_literal: true

# app/models/role.rb
class Role < ApplicationRecord
  belongs_to :user
  belongs_to :organization

  validates_presence_of :role_name
  scope :member, ->{where(role_name: 'member')}
end
