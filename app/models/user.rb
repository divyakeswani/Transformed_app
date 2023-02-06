class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #  :timeoutable  and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable, :trackable

  has_many :organization_profiles
  has_one :user_profiles

  accepts_nested_attributes_for :organization_profiles
  accepts_nested_attributes_for :user_profiles
end
