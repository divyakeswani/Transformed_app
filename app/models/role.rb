# frozen_string_literal: true

# app/models/role.rb
class Role < ApplicationRecord
  belongs_to :user
  validates_presence_of :role_name
end
