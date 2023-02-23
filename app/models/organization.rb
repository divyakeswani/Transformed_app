# frozen_string_literal: true

# app/models/organization.rb
class Organization < ApplicationRecord
  belongs_to :creator, class_name: 'User',
                    foreign_key: 'creator_id'
  has_many :groups, dependent: :destroy
  has_many :organization_memberships, dependent: :destroy
  has_many :users, through: :organization_memberships
  has_many :roles, dependent: :destroy

  validates_presence_of :organization_name
  validates_uniqueness_of :organization_name
  validates_uniqueness_of :creator_id
end
