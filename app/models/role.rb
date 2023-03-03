class Role < ApplicationRecord
  has_many :user_roles

  VALID_ROLES = ['admin', 'leader', 'member']
  validates :role_name, presence: true, uniqueness: true
  validates :role_name, inclusion: { in: VALID_ROLES }
end
