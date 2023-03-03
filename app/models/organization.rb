# frozen_string_literal: true

# app/models/organization.rb
class Organization < ApplicationRecord
  # Associations
  belongs_to :creator, class_name: 'User',
                    foreign_key: 'creator_id'
  has_many :groups, dependent: :destroy
  has_many :organization_memberships, dependent: :destroy
  has_many :users, through: :organization_memberships
  has_many :user_roles, class_name: 'UserRole', dependent: :destroy
  has_many :roles, through: :user_roles

  # Validations
  validates_presence_of :organization_name
  validates_uniqueness_of :organization_name
  validates_uniqueness_of :creator_id
end
