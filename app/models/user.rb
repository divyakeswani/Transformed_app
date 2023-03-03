# frozen_string_literal: true

# app/models/user.rb
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :timeoutable & :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable,
         :trackable

  # Associations
  has_one :user_profile, class_name: 'UserProfile', dependent: :destroy
  has_one :organization, class_name: 'Organization', foreign_key: 'creator_id',
    dependent: :destroy
  has_one :user_role, class_name: 'UserRole', dependent: :destroy
  has_one :role, through: :user_role
  has_many :groups, foreign_key: 'leader_id', dependent: :destroy
  has_many :group_members, foreign_key: 'member_id', dependent: :destroy
  has_many :organization_memberships, dependent: :destroy
  has_many :invitations, class_name: 'User', as: :invited_by
  # has_one :member, -> { where(role.role_name == 'member') }, class_name: 'Role', through: :user_role


  # def invited
  #   self.invitation_accepted_at.present? ? true : false
  # end
end
