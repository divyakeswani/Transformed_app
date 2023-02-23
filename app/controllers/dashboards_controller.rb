# frozen_string_literal: true

# app/controllers/dashboards_controller.rb
class DashboardsController < ApplicationController
  def index
    @user  = OrganizationMembership.where(organization_id: current_user.organization.id)
    @leader = current_user.organization.roles.where(role_name: 'leader')
    @member = current_user.organization.roles.where(role_name: 'member')
  end
end