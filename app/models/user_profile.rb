class UserProfile < ApplicationRecord
  belongs_to :user
  validates_presence_of :first_name, :phone
end
