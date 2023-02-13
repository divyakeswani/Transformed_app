# frozen_string_literal: true

# app/models/group.rb
class Group < ApplicationRecord
  belongs_to :organization
  belongs_to :leader, class_name: 'User',
                    foreign_key: 'leader_id'

  has_many :group_members, dependent: :destroy
  validates_presence_of :group_name
  validates_uniqueness_of :organization_id, scope: [:group_name]
end
