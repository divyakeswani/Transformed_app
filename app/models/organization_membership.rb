# frozen_string_literal: true

# app/models/organization_membership.rb
class OrganizationMembership < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :organization
end
