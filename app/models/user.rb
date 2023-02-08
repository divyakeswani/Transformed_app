class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #  :timeoutable  and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable, :trackable

  has_one :user_profile, class_name: 'UserProfile', dependent: :destroy
  has_one :organization, class_name: 'Organization',foreign_key: 'creator_id', dependent: :destroy
  has_many :groups, foreign_key: 'leader_id', dependent: :destroy
  has_many :group_members, foreign_key: 'member_id', dependent: :destroy

end
