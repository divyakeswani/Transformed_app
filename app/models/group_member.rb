class GroupMember < ApplicationRecord
  belongs_to :group
  belongs_to :member, class_name: 'User'

  # Validations
  validates_presence_of :group_id, :member_id
  validates_uniqueness_of :member_id, scope: [:group_id]
end
