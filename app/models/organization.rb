class Organization < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  validates_presence_of :organization_name
end
