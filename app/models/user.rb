class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #  :timeoutable  and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable, :trackable

  has_one :user_profile, dependent: :destroy
  has_many :organizations, dependent: :destroy
  has_many :groups, dependent: :destroy
  has_many :group_members, dependent: :destroy

  accepts_nested_attributes_for :organizations
  accepts_nested_attributes_for :user_profile
end
