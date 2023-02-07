class Group < ApplicationRecord
  belongs_to :organization
  belongs_to :leader, class_name: 'User'
end
